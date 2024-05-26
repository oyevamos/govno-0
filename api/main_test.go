package api

import (
	db "github.com/oyevamos/govno0/db/sqlc"
	"github.com/oyevamos/govno0/token"
	"github.com/oyevamos/govno0/util"
	"github.com/stretchr/testify/require"
	"testing"
	"time"
)

func newTestServer(t *testing.T, store db.Store) *Server {
	config := util.Config{
		TokenSymmetricKey:   "randomkeyrandomkeyrandomkeyrandom",
		AccessTokenDuration: time.Minute,
	}

	tokenMaker, err := token.NewJWTMaker(config.TokenSymmetricKey)
	require.NoError(t, err)

	server, err := NewServer(config, store, tokenMaker)
	require.NoError(t, err)

	return server
}
