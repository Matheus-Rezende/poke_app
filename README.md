# PokeApp

![Flutter](https://img.shields.io/badge/Flutter-3.22-blue?logo=flutter)
![MobX](https://img.shields.io/badge/State%20Management-MobX-orange)
![Build](https://img.shields.io/badge/build-passing-brightgreen)
![License](https://img.shields.io/badge/license-MIT-blue)

O **PokeApp** é um aplicativo Flutter desenvolvido com o objetivo de levar o universo Pokémon para o dispositivo de todos os fãs e curiosos, permitindo que conheçam melhor essas criaturas incríveis que marcaram gerações.

<p align="center">
  <img src="assets/screenshots/home.png" width="250" />
  <img src="assets/screenshots/details.png" width="250" />
  <img src="assets/screenshots/favorites.png" width="250" />
</p>

---

## ✨ Funcionalidades

- 🔍 Busca por Pokémons pelo nome.
- 🧪 Filtro por tipo de Pokémon (ex: fogo, água, veneno, etc).
- ⬇️ Carregamento com lazy loading para exibição eficiente de todos os Pokémons.
- ⭐ Possibilidade de favoritar seus Pokémons preferidos.

---

## 🛠️ Tecnologias Utilizadas

- [Flutter](https://flutter.dev/)
- [MobX](https://pub.dev/packages/mobx) – Gerenciamento de estado reativo
- [Modular](https://pub.dev/packages/flutter_modular) – Gerenciamento de rotas e injeção de dependência
- [Dartz](https://pub.dev/packages/dartz) – Uso do `Either` para tratamento funcional de falhas
- [PokeAPI](https://pokeapi.co/) – API pública de dados sobre Pokémon

---

## ▶️ Como executar o projeto

1. Clone o repositório:
   ```bash
   git clone https://github.com/seu-usuario/pokeapp.git
   cd pokeapp
   ```

2. Instale as dependências:
   ```bash
   flutter pub get
   ```

3. Gere os arquivos automáticos do MobX:
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

4. Execute o app:
   ```bash
   flutter run
   ```

---

## 📁 Estrutura do Projeto

O projeto segue uma arquitetura modular com separação clara entre **dados**, **interações**, **interface** e **módulos de funcionalidade**:

```
lib/
├── app/
│   ├── core/
│   │   ├── data/                # Camada de dados genérica (adapters, datasources, repositórios, serviços)
│   │   ├── interactor/         # Entidades, repositórios de domínio, states, stories e utilitários
│   │   ├── routes/             # Gerenciamento de rotas
│   │   └── ui/                 # Temas, estilos, componentes globais
├── modules/
│   ├── favorites/              # Módulo de Pokémons favoritados
│   │   └── pages/
│   ├── menu/                   # Menu principal
│   │   ├── interactor/
│   │   │   └── stories/
│   │   └── widgets/
│   ├── onboard/                # Tela de introdução/onboarding
│   │   ├── data/
│   │   │   └── repositories/
│   │   ├── interactor/
│   │   │   ├── repositories/
│   │   │   ├── states/
│   │   │   └── stories/
│   │   ├── pages/
│   │   └── widgets/
│   ├── pokedex/                # Módulo principal da Pokédex
│   │   ├── data/
│   │   │   ├── models/
│   │   │   └── repositories/
│   │   ├── interactor/
│   │   │   ├── entities/
│   │   │   ├── repositories/
│   │   │   ├── states/
│   │   │   ├── stories/
│   │   │   └── utils/
│   │   └── ui/
│   │       ├── pages/
│   │       └── widgets/
│   ├── profile/                # Tela de perfil do usuário
│   │   └── pages/
│   └── regions/                # Tela de regiões do mundo Pokémon
│       └── pages/
```

---

## 📄 Licença

Este projeto está licenciado sob a licença MIT.  
Veja o arquivo [LICENSE](LICENSE) para mais informações.

---

## 👨‍💻 Autor

Desenvolvido por **Matheus Alves** – apaixonado por Flutter e pelo universo Pokémon.  
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Perfil-0077B5?logo=linkedin)](https://www.linkedin.com/in/seu-perfil)  
[![GitHub](https://img.shields.io/badge/GitHub-seu--usuario-181717?logo=github)](https://github.com/seu-usuario)
