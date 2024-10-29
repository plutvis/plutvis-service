package main

import (
	"flag"
	"fmt"

	"github.com/plutvis/plutvis-service/migrate"
)

func main() {
	var migrateSchemaOnly bool
	flag.BoolVar(&migrateSchemaOnly, "migrate-schema-only", false, "The app will only migrate SQL schema and then quit.")
	flag.Parse()

	migrate.Up()
	fmt.Println("Migration has been applied")
	if migrateSchemaOnly {
		fmt.Println("Quit since --migrate-schema-only is specified")
		return
	}
	
}
