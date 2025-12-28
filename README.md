# LengaEdu - Plataforma de Simulações Educativas

LengaEdu é um ecossistema educacional robusto desenvolvido em Flutter, projetado especificamente para ambientes desktop com operação **100% Offline**. Ele serve como um hospedeiro dinâmico para simulações interativas de diversas disciplinas, suportando tecnologias Web e nativas de alta performance.

---

## � Arquitetura do Projeto

O projeto utiliza uma arquitetura modular baseada em **Engines Intercambiáveis**, permitindo que o Flutter atue como a camada de interface e controle (Outer Shell), enquanto o conteúdo pedagógico roda em "caixas" isoladas.

### Componentes Principais:

1.  **Outer Shell (Flutter UI)**: Gerencia a navegação, busca, listagem por disciplinas e a interface de visualização (Sidebar de parâmetros e Status de variáveis).
2.  **Simulation Controller**: Central de estado (via `Provider/ChangeNotifier`) que sincroniza os sliders da UI com o motor da simulação.
3.  **Communication Bridge**:
    *   **Web Bridge**: Utiliza `JavaScript Handlers` para receber dados da WebView e `evaluateJavaScript` para enviar comandos à simulação.
    *   **Native Bridge**: Passa uma referência direta do controlador para o plugin Flutter, permitindo atualizações de estado em microgramas (60 FPS).
4.  **Data Layer**: Gerenciada pelo `SimulationRepository`, que utiliza o sistema de arquivos para carregar dinamicamente o catálogo de conteúdos sem necessidade de recompilação do app.

---

## 📄 Especificação dos Formatos JSON

O app é totalmente orientado por dados (Data-Driven). Existem dois tipos de manifestos fundamentais:

### 1. App Manifesto (`appManifest.json`)
Localizado na raiz do diretório de conteúdos. Define a estrutura global do app.

```json
{
  "version": "2.4.1 LT",
  "subjects": [
    {
      "id": "physics",
      "name": "Física",
      "description": "Mecânica, Óptica e Termodinâmica",
      "icon": "0xe566",
      "color": "0xFF6200EE",
      "simulations": ["sim_gravity", "sim_pendulum"]
    }
  ]
}
```

| Campo | Representação |
| :--- | :--- |
| `version` | String exibida no rodapé do app. |
| `subjects` | Lista de disciplinas/categorias. |
| `subjects.id` | ID interno que deve coincidir com o nome da pasta da disciplina. |
| `subjects.icon` | Codepoint Hex (ex: `0xe566`) do ícone do Material Design. |
| `subjects.color` | Cor ARGB em Hexadecimal para o tema da disciplina. |
| `subjects.simulations` | Lista de IDs de simulações que pertencem a esta disciplina. |

### 2. Simulation Manifesto (`simulation.json`)
Localizado na pasta de cada simulação. Define o comportamento e interface da simulação.

```json
{
  "id": "sim_gravity",
  "name": "Lei da Gravidade",
  "description": "Simulação interativa da queda livre.",
  "type": "native",
  "entry": "gravity",
  "icon": "0xe54d",
  "parameters": [
    {
      "id": "height",
      "label": "Altura",
      "type": "range",
      "min": 1, "max": 50, "default": 10.0,
      "unit": "m"
    }
  ],
  "variables": [
    {
      "id": "velocity",
      "label": "Velocidade",
      "unit": "m/s",
      "color": "emerald"
    }
  ]
}
```

#### Detalhes dos Elementos:
- **`type`**: 
  - `web`: Carrega um arquivo HTML local.
  - `native`: Carrega um plugin Dart registrado no app.
- **`entry`**: Caminho relativo do arquivo (HTML) ou o ID de registro (Nativo).
- **`parameters`**: Widgets de controle gerados dinamicamente na Sidebar. Suporta:
  - `range`: Gera um Slider (requer `min`, `max`, `default`).
  - `boolean`: Gera um Switch (requer `default`).
- **`variables`**: Estatísticas em tempo real exibidas no cabeçalho. As simulações devem enviar dados vinculados ao `id` definido aqui.

---

## 🚀 Guia de Adição de Conteúdo

### Adicionando Simulação Web:
1.  Crie a pasta: `content/physics/minha_simulacao/`.
2.  Coloque seu `index.html` e o `simulation.json`.
3.  No seu JavaScript, envie dados para o Flutter:
    ```javascript
    // Para atualizar uma variável monitorada
    window.flutter_inappwebview.callHandler('updateVariable', 'meu_id_variavel', novoValor);
    ```

### Adicionando Simulação Nativa:
1.  Crie o arquivo Dart em `lib/plugins/native/simulations/`.
2.  Implemente `SimulationPlugin`.
3.  Registre no `NativeSimulationRegistry.dart`.
4.  No `simulation.json`, aponte o `entry` para o ID de registro.

---

## 🎨 Sistema de Ícones
O projeto utiliza codepoints haxadecimais do Material Symbols para ícones dinâmicos.
- Para encontrar um código, acesse [fonts.google.com/icons](https://fonts.google.com/icons).
- Selecione o ícone e copie o valor "Codepoint" (ex: `e54d`).
- Salve no JSON como `0xe54d`.

---

## ⚙️ Configurações Desktop
- **Base de Dados**: O app utiliza o diretório local definido em `DirectoryConsts.contentDir`.
- **Cálculo de Tamanho**: O repositório realiza uma varredura recursiva (`dir.list`) em runtime para somar o tamanho de todos os arquivos de uma simulação antes de exibi-la na lista, garantindo transparência sobre o uso de disco.
