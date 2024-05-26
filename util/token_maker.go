package util

import (
	"github.com/dgrijalva/jwt-go"
	"github.com/oyevamos/govno0/token"
	"time"
)

// TokenMaker is a JSON web token maker
type TokenMaker struct {
	secretKey string
}

// NewTokenMaker creates a new TokenMaker
func NewTokenMaker(secretKey string) *TokenMaker {
	return &TokenMaker{secretKey}
}

// CreateToken creates a new token for a specific username and duration
func (maker *TokenMaker) CreateToken(username string, role string, duration time.Duration) (string, *token.Payload, error) {
	payload, err := token.NewPayload(username, role, duration)
	if err != nil {
		return "", nil, err
	}

	jwtToken := jwt.NewWithClaims(jwt.SigningMethodHS256, payload)
	tokenString, err := jwtToken.SignedString([]byte(maker.secretKey))
	if err != nil {
		return "", nil, err
	}

	return tokenString, payload, nil
}

// VerifyToken checks if the token is valid or not
func (maker *TokenMaker) VerifyToken(token string) (*token.Payload, error) {
	// Implement token verification
	return nil, nil
}
