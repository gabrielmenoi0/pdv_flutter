<div align="center">
  <img width="300" src="assets/image/sti3-logo.png" align="center">
</div>

<div align="center">
    <h1>
      PDV Flutter
    </h1>
</div>



<div align="center">

• [Arquitetura, técnicas e bibliotecas](#arquitetura)
• [Abrir e rodar](#abrir-e-rodar)
• [Licença](#licença)

</div>

<div align="center">

[![Status](https://img.shields.io/badge/Status-Concluido-green)]()
[![Flutter](https://img.shields.io/badge/Flutter-3.24.3-%230066cc)](https://docs.flutter.dev/get-started/install)

</div>

<div align="left">

## Sobre

O projeto PDV Flutter, desenvolvido no desafio técnico do precesso seletivo da STI3 Sistemas!



## Arquitetura, Técnicas e Bibliotecas

### Arquitetura

**Estrutura de arquivos:**

<table>
<tr>
<td>

**lib/**<br/>
**├── core**<br/>
**├── product**<br/>
**├── view**<br/>
**├── viewmodel**<br/>
**└── main.dart**<br/>

**module/**<br/>
**└── architecture_theme**<br/>

**scripts/**<br/>
**├── android_build.sh**<br/>
**├── build.sh**<br/>
**├── lang.sh**<br/>
**└── launcher_icons.sh**<br/>

- Legenda: lib/
  core: arquivos que padronizam a estilização do app, uso de imagens, rotas de navegação, validações e extensões
  product: Verificações do sistema
  view: interface do usuário
  main: arquivo inicial do projeto

</td>
</tr>
</table>

### Técnicas

- **MVVM**: Utilizamos o padrão MVVM (Model-View-ViewModel) para a organização da arquitetura do
  aplicativo. Esse padrão ajuda a separar a lógica de negócios da interface do usuário, facilitando
  a manutenção e testabilidade do código.
- **Scripts**: Utilizamos scripts personalizados para automatizar tarefas recorrentes, como
  construção do aplicativo, geração de recursos e internacionalização.
- **Centralização de temas**: Todas as cores, temas e fontes utilizados no aplicativo estão
  centralizados no módulo `architecture_theme`, permitindo fácil personalização e consistência
  visual.
- **Centralização de assets**: As imagens, ícones e outros arquivos de recursos estão armazenados na
  pasta `assets/` e são facilmente acessíveis e configuráveis por meio das classes `ImagePaths`
- **Centralização de textos e linguagens**: Utilizamos a biblioteca `Easy Localization` para
  centralizar e gerenciar os textos e traduções utilizados no aplicativo. Isso permite a fácil
  adição de suporte a múltiplos idiomas.


### Bibliotecas

**Essenciais Core:**

- [Mobx](https://pub.dev/packages/mobx) - Gerenciamento de estado local.
- [Provider](https://pub.dev/packages/provider) - Gerenciamento de estado global.
- [Dio](https://pub.dev/packages/dio) - Requisições HTTP.
- [Shared preferences](https://pub.dev/packages/hive) - Gerenciamento de dados offline.
- [Easy Localization](https://pub.dev/packages/easy_localization) - Centralização e gerenciamento de
  textos e traduções.
- [Build_runner](https://pub.dev/packages/build_runner) - Utilizado como complemento para
  bibliotecas que geram arquivos de configuração, como o Mobx e o Json Annotation.

**Essenciais UI:**



- [Menu bar](https://pub.dev/packages/menu_bar) - Menu superior de navegação.
- [Gráficos](https://pub.dev/packages/syncfusion_flutter_charts) - Graficos usados nos relatórios.
- [Gerador de Excel](https://pub.dev/packages/syncfusion_flutter_xlsio) - Exportar dados para excel.

**Utilitários Core:**

- [Kartal](https://pub.dev/packages/kartal) - Acesso rápido e fácil a métodos do contexto.
- [Json annotation](https://pub.dev/packages/json_annotation) - Geração de código JSON a partir de
  anotações.
- [Flutter launcher icons](https://pub.dev/packages/flutter_launcher_icons) - Geração de ícones para
  diferentes plataformas.

**Utilitários UI:**

- [Flushbar](https://pub.dev/packages/another_flushbar) - Exibição de mensagens de sucesso e alerta.
- [Spinkit](https://pub.dev/packages/flutter_spinkit) - Widget de loading.

## Abrir e rodar

**Para executar este projeto você precisa:**

1. Ter o [Flutter](https://flutter.dev/docs/get-started/install) e
   o [Dart](https://dart.dev/get-dart) instalado na sua máquina. <br/>
2. Ter alguma IDE como o [Android Studio](https://developer.android.com/studio). <br/>
3. Baixar e instalar o [Git](https://git-scm.com/downloads). <br/>
4. Abrir o Git e clonar o projeto do [GitHub](https://github.com/gabrielmenoi0/pdv_flutter)
   usando o comando `git clone <HTTPS disponível no Github>`. <br/>
5. Ao abrir o projeto, execute o comando `flutter pub get` na raiz do projeto ou clique no
   arquivo [Pubspec.yaml](pubspec.yaml) e clique no botão no canto superior direito
   escrito `Pub get` e em seguida aguarde o carregamento as dependências do projeto. <br/>
6. O processo de execução do projeto funcionará através de um botão de play na parte superior que
   ambas IDES dispõem. Caso escolha rodar o projeto via linha de comandos, utilize o
   comando `flutter run windows`. Lembre-se de antes de executar o comando de navegar até a pasta do projeto
   antes.


</div>

<div align="center">
    <img src="https://forthebadge.com/images/badges/built-with-love.svg" />
    <img src="https://forthebadge.com/images/badges/built-by-developers.svg" />
</div>