import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: TextForm(),
    ),
  );
}

class TextForm extends StatefulWidget {
  const TextForm({Key? key}) : super(key: key);

  @override
  State<TextForm> createState() => _TextFormState();
}

class _TextFormState extends State<TextForm> {
  TextEditingController _controllerEtanol = TextEditingController();
  TextEditingController _controllerGasolina = TextEditingController();
  TextEditingController _controllerKmEstradaEtanol = TextEditingController();
  TextEditingController _controllerKmCidadeEtanol = TextEditingController();
  TextEditingController _controllerKmEstradaGasolina = TextEditingController();
  TextEditingController _controllerKmCidadeGasolina = TextEditingController();
  TextEditingController _controllerDistancia = TextEditingController();
  String _textoResultadoDetalhado = "";
  String _textoResultado = "";

  void _calcular() {
    try {
      double precoEtanol = double.parse(_controllerEtanol.text);
      double precoGasolina = double.parse(_controllerGasolina.text);
      double kmEtanolEstrada = double.parse(_controllerKmEstradaEtanol.text);
      double kmGasolinaEstrada =
          double.parse(_controllerKmEstradaGasolina.text);
      double kmEtanolCidade = double.parse(_controllerKmCidadeEtanol.text);
      double kmGasolinaCidade = double.parse(_controllerKmCidadeGasolina.text);
      double distancia = double.parse(_controllerDistancia.text);

      double custoEtanolEstrada = (distancia / kmEtanolEstrada) * precoEtanol;
      double custoGasolinaEstrada =
          (distancia / kmGasolinaEstrada) * precoGasolina;
      double custoEtanolCidade = (distancia / kmEtanolCidade) * precoEtanol;
      double custoGasolinaCidade =
          (distancia / kmGasolinaCidade) * precoGasolina;

      setState(() {
        _textoResultado = calcularRecomendacao(
          custoEtanolEstrada,
          custoEtanolCidade,
          custoGasolinaEstrada,
          custoGasolinaCidade,
        );

        _textoResultadoDetalhado = """
      Na cidade:
      Álcool: 100 km * R\$ $precoEtanol/km = R\$ ${custoEtanolCidade.toStringAsFixed(2)}
      Gasolina: 100 km * R\$ $precoGasolina/km = R\$ ${custoGasolinaCidade.toStringAsFixed(2)}
      Na estrada:
      Álcool: 100 km * R\$ $precoEtanol/km = R\$ ${custoEtanolEstrada.toStringAsFixed(2)}
      Gasolina: 100 km * R\$ $precoGasolina/km = R\$ ${custoGasolinaEstrada.toStringAsFixed(2)}
      Portanto, para percorrer 100 km:
      Na cidade, com álcool, gastará R\$ ${custoEtanolCidade.toStringAsFixed(2)}.
      Na cidade, com gasolina, gastará R\$ ${custoGasolinaCidade.toStringAsFixed(2)}.
      Na estrada, com álcool, gastará R\$ ${custoEtanolEstrada.toStringAsFixed(2)}.
      Na estrada, com gasolina, gastará R\$ ${custoGasolinaEstrada.toStringAsFixed(2)}.
      """;
      });
    } catch (e) {
      setState(() {
        _textoResultado =
            "Erro: Por favor, preencha todos os campos corretamente.";
        _textoResultadoDetalhado = "";
      });
    }
  }

  String calcularRecomendacao(
    double custoEtanolEstrada,
    double custoEtanolCidade,
    double custoGasolinaEstrada,
    double custoGasolinaCidade,
  ) {
    double custoMinimoEtanol = custoEtanolEstrada;
    double custoMinimoGasolina = custoGasolinaEstrada;
    String tipoCombustivel = "etanol";

    if (custoEtanolCidade < custoMinimoEtanol) {
      custoMinimoEtanol = custoEtanolCidade;
      tipoCombustivel = "etanol";
    }

    if (custoGasolinaCidade < custoMinimoGasolina) {
      custoMinimoGasolina = custoGasolinaCidade;
      tipoCombustivel = "gasolina";
    }

    if (custoMinimoEtanol < custoMinimoGasolina) {
      return "A melhor opção é o $tipoCombustivel. O custo será de R\$${custoMinimoEtanol.toStringAsFixed(2)}.";
    } else {
      return "A melhor opção é a gasolina. O custo será de R\$${custoMinimoGasolina.toStringAsFixed(2)}.";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Abastecimento'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Informe os preços:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Preço do etanol, ex: 3,41',
                ),
                style: const TextStyle(
                  fontSize: 18,
                ),
                controller: _controllerEtanol,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Preço da gasolina, ex: 4,50',
                ),
                style: const TextStyle(
                  fontSize: 18,
                ),
                controller: _controllerGasolina,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Informe a kilometragem:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'KM/L Estrada Etanol',
                ),
                style: const TextStyle(
                  fontSize: 18,
                ),
                controller: _controllerKmEstradaEtanol,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'KM/L Cidade Etanol',
                ),
                style: const TextStyle(
                  fontSize: 18,
                ),
                controller: _controllerKmCidadeEtanol,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'KM/L Estrada Gasolina',
                ),
                style: const TextStyle(
                  fontSize: 18,
                ),
                controller: _controllerKmEstradaGasolina,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'KM/L Cidade Gasolina',
                ),
                style: const TextStyle(
                  fontSize: 18,
                ),
                controller: _controllerKmCidadeGasolina,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Informe qual a distancia que ira percorrer',
                ),
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                controller: _controllerDistancia,
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue),
              ),
              onPressed: _calcular,
              child: Text(
                'Veja os resultados',
                style: TextStyle(fontSize: 20),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Resultado:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                _textoResultado,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                _textoResultadoDetalhado,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
