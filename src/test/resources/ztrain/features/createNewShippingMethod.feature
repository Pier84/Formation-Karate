@ztrain
Feature: Create new shipping method

  Background:

     # J'indique l'url qui va etre utilis� pour tous les sc�narios de cette feature en faisant r�f�rence � la variable one.url sp�cifi� dans le karate-config.js
    * url one.url
    # Je stock dans la variable req le fichier � passer dans le body de ma requete Post
    * def req = read ('classpath:ztrain/data/createNewShippingMethod.json')
    * def NomProduitUnique = Java.type('Uuid.prdUnique')
    # Je stock dans la variable PUnique une chaine de caracteres al�atoire
    * def PUnique = NomProduitUnique.instance.unique()
    * def temp = req.designation
    * print temp
    * set req.designation = temp + PUnique
    * print req.designation




  Scenario: Create a new shipping method
    Given def TokenGen = call read('classpath:ztrain/features/loginUser.feature')
    And print TokenGen.response.token

    Given path '/shipping-method/create'
    And header Content-Type = 'application/json'
    And header Authorization = "Bearer " + TokenGen.response.token
    And request  req
    When method POST
    Then status 201


    # check if shipping method already exists



      Given path '/shipping-method/create'
      And header Content-Type = 'application/json'
      And header Authorization = "Bearer " + TokenGen.response.token
      And request req
      When method POST
      Then status 403
      And response.error = "Cette methode de livraison existe d�ja"
