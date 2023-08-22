<?php

class DatabaseConnection {

    private PDO $connection;
    /**
     * @throws Exception
     */
    public function __construct(string $host, string $db, string $user, string $pass) {
        try {
            $this->connection = new PDO("mysql:host=$host;dbname=$db", $user, $pass);
            $this->connection->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        } catch (PDOException $e) {
            throw new RuntimeException("Database connection error: " . $e->getMessage());
        }
    }

    public function getConnection(): PDO
    {
        return $this->connection;
    }
}
