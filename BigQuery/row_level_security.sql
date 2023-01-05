CREATE ROW ACCESS POLICY
    apac_filter
ON
    dataset1.table1
GRANT TO
("group:sales-apac@example.com","user:jon@example.com")
FILTER USING
(REGION="APAC")