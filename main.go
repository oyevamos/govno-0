package main

import (
	"database/sql"
	_ "github.com/lib/pq"
	"github.com/oyevamos/govno0/api"
	db "github.com/oyevamos/govno0/db/sqlc"
	"github.com/oyevamos/govno0/token"
	"github.com/oyevamos/govno0/util"
	"log"
)

func main() {
	config, err := util.LoadConfig(".")
	if err != nil {
		log.Fatal("cannot load config:", err)
	}

	conn, err := sql.Open(config.DBDriver, config.DBSource)
	if err != nil {
		log.Fatal("cannot connect to db:", err)
	}

	store := db.NewStore(conn)
	tokenMaker, err := token.NewJWTMaker(config.TokenSymmetricKey)
	if err != nil {
		log.Fatal("cannot create token maker:", err)
	}

	server, err := api.NewServer(config, store, tokenMaker)
	if err != nil {
		log.Fatal("cannot create server:", err)
	}

	err = server.Start(config.ServerAddress)
	if err != nil {
		log.Fatal("cannot start server:", err)
	}
}
