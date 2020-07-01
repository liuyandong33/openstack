#!/bin/bash
if [[ "${ENV}" = 'development' ]];
then
cat << EOF > bootstrap-development.properties
spring.cloud.nacos.config.server-addr=${DEVELOPMENT_NACOS_CONFIG_SERVER_ADDR}
spring.cloud.nacos.config.username=${DEVELOPMENT_NACOS_CONFIG_USERNAME}
spring.cloud.nacos.config.password=${DEVELOPMENT_NACOS_CONFIG_PASSWORD}
spring.cloud.nacos.config.namespace=${DEVELOPMENT_NACOS_CONFIG_NAMESPACE}
spring.cloud.nacos.config.group=${DEVELOPMENT_NACOS_CONFIG_GROUP}

spring.cloud.nacos.discovery.server-addr=${DEVELOPMENT_NACOS_DISCOVERY_SERVER_ADDR}
spring.cloud.nacos.discovery.username=${DEVELOPMENT_NACOS_DISCOVERY_USERNAME}
spring.cloud.nacos.discovery.password=${DEVELOPMENT_NACOS_DISCOVERY_PASSWORD}
spring.cloud.nacos.discovery.namespace=${DEVELOPMENT_NACOS_DISCOVERY_NAMESPACE}
spring.cloud.nacos.discovery.group=${DEVELOPMENT_NACOS_DISCOVERY_GROUP}
EOF

elif [[ ${ENV} = 'test' ]];
then
cat << EOF > bootstrap-test.properties
spring.cloud.nacos.config.server-addr=${TEST_NACOS_CONFIG_SERVER_ADDR}
spring.cloud.nacos.config.username=${TEST_NACOS_CONFIG_USERNAME}
spring.cloud.nacos.config.password=${TEST_NACOS_CONFIG_PASSWORD}
spring.cloud.nacos.config.namespace=${TEST_NACOS_CONFIG_NAMESPACE}
spring.cloud.nacos.config.group=${TEST_NACOS_CONFIG_GROUP}

spring.cloud.nacos.discovery.server-addr=${TEST_NACOS_DISCOVERY_SERVER_ADDR}
spring.cloud.nacos.discovery.username=${TEST_NACOS_DISCOVERY_USERNAME}
spring.cloud.nacos.discovery.password=${TEST_NACOS_DISCOVERY_PASSWORD}
spring.cloud.nacos.discovery.namespace=${TEST_NACOS_DISCOVERY_NAMESPACE}
spring.cloud.nacos.discovery.group=${TEST_NACOS_DISCOVERY_GROUP}
EOF

elif [[ ${ENV} = 'production' ]];
then
cat << EOF > bootstrap-production.properties
spring.cloud.nacos.config.server-addr=${PRODUCTION_NACOS_CONFIG_SERVER_ADDR}
spring.cloud.nacos.config.username=${PRODUCTION_NACOS_CONFIG_USERNAME}
spring.cloud.nacos.config.password=${PRODUCTION_NACOS_CONFIG_PASSWORD}
spring.cloud.nacos.config.namespace=${PRODUCTION_NACOS_CONFIG_NAMESPACE}
spring.cloud.nacos.config.group=${PRODUCTION_NACOS_CONFIG_GROUP}

spring.cloud.nacos.discovery.server-addr=${PRODUCTION_NACOS_DISCOVERY_SERVER_ADDR}
spring.cloud.nacos.discovery.username=${PRODUCTION_NACOS_DISCOVERY_USERNAME}
spring.cloud.nacos.discovery.password=${PRODUCTION_NACOS_DISCOVERY_PASSWORD}
spring.cloud.nacos.discovery.namespace=${PRODUCTION_NACOS_DISCOVERY_NAMESPACE}
spring.cloud.nacos.discovery.group=${PRODUCTION_NACOS_DISCOVERY_GROUP}
EOF
fi

DEVELOPMENT_NACOS_CONFIG_SERVER_ADDR=47.114.152.251:8848
DEVELOPMENT_NACOS_CONFIG_USERNAME=nacos
DEVELOPMENT_NACOS_CONFIG_PASSWORD=nacos
DEVELOPMENT_NACOS_CONFIG_NAMESPACE=e2d5047b-9f03-476e-94b6-fe7f3bfb7b1c
DEVELOPMENT_NACOS_CONFIG_GROUP=build_dream

DEVELOPMENT_NACOS_DISCOVERY_SERVER_ADDR=47.114.152.251:8848
DEVELOPMENT_NACOS_DISCOVERY_USERNAME=nacos
DEVELOPMENT_NACOS_DISCOVERY_PASSWORD=nacos
DEVELOPMENT_NACOS_DISCOVERY_NAMESPACE=e2d5047b-9f03-476e-94b6-fe7f3bfb7b1c
DEVELOPMENT_NACOS_DISCOVERY_GROUP=build_dream

TEST_NACOS_CONFIG_SERVER_ADDR=47.114.152.251:8848
TEST_NACOS_CONFIG_USERNAME=nacos
TEST_NACOS_CONFIG_PASSWORD=nacos
TEST_NACOS_CONFIG_NAMESPACE=e2d5047b-9f03-476e-94b6-fe7f3bfb7b1c
TEST_NACOS_CONFIG_GROUP=build_dream

TEST_NACOS_DISCOVERY_SERVER_ADDR=47.114.152.251:8848
TEST_NACOS_DISCOVERY_USERNAME=nacos
TEST_NACOS_DISCOVERY_PASSWORD=nacos
TEST_NACOS_DISCOVERY_NAMESPACE=e2d5047b-9f03-476e-94b6-fe7f3bfb7b1c
TEST_NACOS_DISCOVERY_GROUP=build_dream

PRODUCTION_NACOS_CONFIG_SERVER_ADDR=47.114.152.251:8848
PRODUCTION_NACOS_CONFIG_USERNAME=nacos
PRODUCTION_NACOS_CONFIG_PASSWORD=nacos
PRODUCTION_NACOS_CONFIG_NAMESPACE=e2d5047b-9f03-476e-94b6-fe7f3bfb7b1c
PRODUCTION_NACOS_CONFIG_GROUP=build_dream

PRODUCTION_NACOS_DISCOVERY_SERVER_ADDR=47.114.152.251:8848
PRODUCTION_NACOS_DISCOVERY_USERNAME=nacos
PRODUCTION_NACOS_DISCOVERY_PASSWORD=nacos
PRODUCTION_NACOS_DISCOVERY_NAMESPACE=e2d5047b-9f03-476e-94b6-fe7f3bfb7b1c
PRODUCTION_NACOS_DISCOVERY_GROUP=build_dream