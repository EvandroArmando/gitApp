
      
void main() {
  int idade = 25;
  double altura = 1.75;
  bool gostaDeFlutter = true;
  String nome = "Evandro";
  
  List<String> linguagens = ["Dart", "JavaScript", "Python"];
  Map<String, String> usuario = {"nome": nome, "país": "Angola"};

  print("Nome: $nome, Idade: $idade, Altura: $altura");
  print("Gosta de Flutter? $gostaDeFlutter");
  print("Linguagens favoritas: ${linguagens.join(", ")}");
  print("Informações do usuário: $usuario");





}