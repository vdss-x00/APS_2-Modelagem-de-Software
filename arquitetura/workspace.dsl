
workspace "Sistema de Manutenção Preventiva IoT" {

    model {
        operador = person "Operador" {
            description "Responsável por acompanhar as condições operacionais das máquinas."
        }

        tecnico = person "Técnico" {
            description "Responsável por executar atividades de manutenção."
        }

        iot = softwareSystem "Sistema de Manutenção Preventiva IoT" {

            emqx = container "EMQX" {
                description "Broker MQTT responsável pela comunicação com os sensores industriais."
                technology "MQTT Broker"
            }

            kafka = container "Apache Kafka" {
                description "Plataforma de streaming responsável pela distribuição dos eventos."
                technology "Event Streaming"
            }

            timescale = container "TimescaleDB" {
                description "Banco de dados responsável pelo armazenamento das séries temporais."
                technology "PostgreSQL / TimescaleDB"
            }

            grafana = container "Grafana" {
                description "Ferramenta responsável pela visualização e monitoramento operacional."
                technology "Grafana"
            }
        }

        operador -> iot.grafana "Visualiza indicadores e leituras"
        tecnico -> iot.grafana "Consulta informações operacionais"

        iot.emqx -> iot.kafka "Encaminha leituras dos sensores" "Integração MQTT/Kafka"
        iot.kafka -> iot.timescale "Entrega eventos para persistência" "Consumer"
        iot.grafana -> iot.timescale "Consulta séries temporais" "SQL"
    }

    views {
        container iot "C4-Container" {
            include *
            autoLayout lr
        }

        theme default
    }
}
