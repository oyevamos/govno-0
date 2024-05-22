migrateup:
	migrate -path db/migration -database "postgresql://govno:govno@localhost:5437/govno?sslmode=disable" -verbose up
migratedown:
	migrate -path db/migration -database "postgresql://govno:govno@localhost:5437/govno?sslmode=disable" -verbose down
sqlc:
	sqlc generate
test:
	go test -v -cover ./...
server:
	go run main.go
mock:
	mockgen -package mockdb -destination db/mock/store.go github.com/oyevamos/govno0/db/sqlc Store
.PHONY:
	migrateup migratedown sqlc test server mock
