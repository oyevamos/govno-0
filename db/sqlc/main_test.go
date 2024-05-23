package db

import (
	"database/sql"
	"github.com/oyevamos/govno0/util"
	"log"
	"os"
	"testing"

	_ "github.com/lib/pq"
)

//const (
//	dbDriver = "postgres"
//	dbSource = "postgresql://govno:govno@localhost:5437/govno?sslmode=disable"
//)

var testQueries *Queries
var testDB *sql.DB

func TestMain(m *testing.M) {
	config, err := util.LoadConfig("../..")
	testDB, err = sql.Open(config.DBDriver, config.DBSource)
	if err != nil {
		log.Fatal("cannot connect to db", err)
	}
	testQueries = New(testDB)

	os.Exit(m.Run())
}
