package config

import (
	"fmt"
	"os"

	"github.com/spf13/viper"
)

const envVarName = "ENV"

var config Config

func init() {
	envName := os.Getenv(envVarName)
	if envName == "" {
		panic("'" + envVarName + "'" + " env variable is not presented")
	}

	configFileName := "config-" + envName

	viper.SetConfigName(configFileName)
	viper.SetConfigType("yml")
	viper.AddConfigPath("./config/environments") 
	if err := viper.ReadInConfig(); err != nil { 
		panic(fmt.Errorf("unable to read config file: %w", err))
	}

	if err := viper.Unmarshal(&config); err != nil {
		panic(fmt.Errorf("unable to unmarshal config: %w", err))
	}
}

type DBConfig struct {
	Url string
	MigrationsPath string
}

type Config struct {
	DB DBConfig
}

func Get() Config {
	return config
}