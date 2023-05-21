# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.create([
    {name: "Carlos Galecio", mail: "cgale@gmail.com", uuid: "ecc0e415-3a6f-4d25-b8c1-19055b891cbf", token: ""},
    {name: "Pep Guardiola", mail: "pepomas@forcemc.com", uuid: "c901f07c-85f7-4f47-8778-84633c129e2b", token: ""},
    {name: "Celso Moya", mail: "cmoya@gmail.com", uuid: "976b5729-dd61-49c5-bd5c-c5ec5ee3b212", token: ""}
])
