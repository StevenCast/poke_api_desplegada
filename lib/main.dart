import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(PokemonApp());
}

class PokemonApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokémon API',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        textTheme: TextTheme(
          bodyLarge: TextStyle(fontSize: 16, color: Colors.white),
          bodyMedium: TextStyle(fontSize: 14, color: Colors.white.withOpacity(0.7)),
        ),
        scaffoldBackgroundColor: Colors.teal.shade50,
      ),
      home: PokemonList(),
    );
  }
}

class PokemonList extends StatefulWidget {
  @override
  _PokemonListState createState() => _PokemonListState();
}

class _PokemonListState extends State<PokemonList> {
  List<Map<String, dynamic>> _pokemonList = [];
  List<Map<String, dynamic>> _filteredPokemonList = [];
  bool _isLoading = false;
  TextEditingController _searchController = TextEditingController();
  TextEditingController _ipSearchController = TextEditingController();
  String _ipInfo = '';

  @override
  void initState() {
    super.initState();
    fetchPokemon();
    _searchController.addListener(_filterPokemons);
  }

  Future<void> fetchPokemon() async {
    setState(() {
      _isLoading = true;
    });

    final url = Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=50');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List results = data['results'];

        List<Map<String, dynamic>> pokemonWithImages = [];

        for (var pokemon in results) {
          final detailsResponse = await http.get(Uri.parse(pokemon['url']));
          if (detailsResponse.statusCode == 200) {
            final detailsData = json.decode(detailsResponse.body);
            pokemonWithImages.add({
              'name': pokemon['name'],
              'image': detailsData['sprites']['front_default'],
              'id': detailsData['id'],
              'height': detailsData['height'],
              'weight': detailsData['weight'],
              'abilities': detailsData['abilities']
                  .map((ability) => ability['ability']['name'])
                  .toList(),
            });
          }
        }

        setState(() {
          _pokemonList = pokemonWithImages;
          _filteredPokemonList = pokemonWithImages;
          _isLoading = false;
        });
      } else {
        throw Exception('Error al cargar los Pokémon.');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Error: $e');
    }
  }

  void _filterPokemons() {
    setState(() {
      _filteredPokemonList = _pokemonList
          .where((pokemon) => pokemon['name']
              .toLowerCase()
              .contains(_searchController.text.toLowerCase()))
          .toList();
    });
  }

  Future<void> _fetchIpInfo() async {
    final ip = _ipSearchController.text;
    final apiKey = '5bfa51c315854c6f8e968cc048c7fb6b'; // Reemplaza con tu API Key de ipstack
    final url = Uri.parse('http://api.ipstack.com/$ip?access_key=$apiKey');

    setState(() {
      _ipInfo = 'Cargando...';
    });

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _ipInfo = '''
IP: ${data['ip']}
Tipo: ${data['type']}
Código del continente: ${data['continent_code']}
Nombre del continente: ${data['continent_name']}
Código del país: ${data['country_code']}
Nombre del país: ${data['country_name']}
Código de la región: ${data['region_code']}
Nombre de la región: ${data['region_name']}
Ciudad: ${data['city']}
Código postal: ${data['zip']}
''';
        });
      } else {
        setState(() {
          _ipInfo = 'No se pudo obtener información para esta IP.';
        });
      }
    } catch (e) {
      setState(() {
        _ipInfo = 'Error al obtener la información de la IP.';
      });
      print('Error: $e');
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _ipSearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal.shade800,
        title: Text(
          'Lista de Pokémon',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Barra de búsqueda para IP
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _ipSearchController,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        hintText: 'Ingresa la IP...',
                        hintStyle: TextStyle(color: Colors.black.withOpacity(0.6)),
                        fillColor: Colors.teal.shade100,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.search, color: Colors.black),
                    onPressed: _fetchIpInfo,
                  ),
                ],
              ),
            ),
            // Mostrar la información de la IP
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                _ipInfo,
                style: TextStyle(fontSize: 14, color: Colors.black),
              ),
            ),
            // Barra de búsqueda para Pokémon
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hintText: 'Buscar Pokémon...',
                  hintStyle: TextStyle(color: Colors.black.withOpacity(0.6)),
                  fillColor: Colors.teal.shade100,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                ),
              ),
            ),
            // Mostrar la lista de Pokémon o indicador de carga
            _isLoading
                ? Center(child: CircularProgressIndicator())
                : Expanded(
                    child: ListView.builder(
                      itemCount: _filteredPokemonList.length,
                      itemBuilder: (context, index) {
                        final pokemon = _filteredPokemonList[index];
                        return Card(
                          elevation: 5,
                          margin: EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.all(16),
                            leading: pokemon['image'] != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(pokemon['image'], width: 50, height: 50, fit: BoxFit.cover),
                                  )
                                : Icon(Icons.image_not_supported),
                            title: Text(
                              pokemon['name'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            onTap: () {
                              _showPokemonDetails(context, pokemon);
                            },
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  void _showPokemonDetails(BuildContext context, Map<String, dynamic> pokemon) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          pokemon['name'],
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),  // Título en negro
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            pokemon['image'] != null
                ? Image.network(pokemon['image'], width: 100, height: 100)
                : Icon(Icons.image_not_supported, size: 50),
            SizedBox(height: 16),
            // Información con texto en color negro
            Text(
              'ID: ${pokemon['id']}',
              style: TextStyle(color: Colors.black),
            ),
            Text(
              'Altura: ${pokemon['height']}',
              style: TextStyle(color: Colors.black),
            ),
            Text(
              'Peso: ${pokemon['weight']}',
              style: TextStyle(color: Colors.black),
            ),
            Text(
              'Habilidades: ${pokemon['abilities'].join(', ')}',
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Cerrar', style: TextStyle(color: Colors.black)),  // Botón en negro
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

}
