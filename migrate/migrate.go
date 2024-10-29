package migrate

import (
	"fmt"

	"github.com/golang-migrate/migrate/v4"
	_ "github.com/golang-migrate/migrate/v4/database/postgres"
	_ "github.com/golang-migrate/migrate/v4/source/file"
	"github.com/plutvis/plutvis-service/config"
)

func Up() {
	m, err := migrate.New(config.Get().DB.MigrationsPath, config.Get().DB.Url)
	if err != nil {
		panic(fmt.Errorf("unable to create 'migrate' instance: %w", err))
	}
	if err = m.Up(); err != migrate.ErrNoChange {
		panic(fmt.Errorf("unable to apply migration: %w", err))
	}
}