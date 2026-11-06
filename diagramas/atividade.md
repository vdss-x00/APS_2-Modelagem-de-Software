```mermaid

swimlane-beta LR

  subgraph Maquina["Máquina"]
    A([Início])
    B[Disponibilizar dados operacionais]
  end

  subgraph Sensor
    C[Capturar leitura dos sensores]
    D[Enviar leitura coletada]
  end

  subgraph BancoDeDados["Banco de Dados"]
    E[Receber leitura]
    F{Leitura válida?}
    G[Armazenar leitura]
    X[Descartar leitura inválida]
    J[Registrar auditoria da leitura]
  end

  subgraph GUI["Interface Gráfica"]
    H[Consultar leituras atualizadas]
    I[Exibir leituras dos sensores]
    Y[Exibir aviso de leitura inválida]
  end

  subgraph Operador
    K[Visualizar leituras]
    L([Fim])
  end

  A --> B
  B --> C
  C --> D
  D --> E
  E --> F

  F -->|"Sim"| G
  F -->|"Não"| X

  G --> Fork
  Fork@{ shape: fork, label: "Fork" }

  Fork --> H
  Fork --> J

  H --> I

  I --> Join
  J --> Join
  Join@{ shape: fork, label: "Join" }

  Join --> K
  K --> L

  X --> J
  X --> Y
  Y --> L




```