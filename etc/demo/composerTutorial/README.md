<!--internal link-->
[HC]: /etc/notes/HyperledgerComposer/README.md "Hyperledger Composer README file"

<!--img-->
[img1]: ./img/1.png "Generating a project skeleton"
[img2]: ./img/2.png "Compiling the application"
[img3]: ./img/3.png "Preparing the environment part 1"
[img4]: ./img/4.png "Preparing the environment part 2"
[img5]: ./img/5.png "Deployment to the network"
[img6]: ./img/6.png "Running a RESTful server"
[img7]: ./img/7.png "Docker currently-running processes"
[img8]: ./img/8.png "Composer's active business network card list. The business network card cannot be updated and is not temponary like the fabric network; the business network card should be deleted and re-add accordingly when redeploying"
[img9]: ./img/9.png "Composer's detailed description of active busines network card"
[rest_server]: ./img/rest_server.png "localhost:3000 or 127.0.0.1:3000 on preferred browser (screenshot using Firefox)"

# Demostration of running a Composer application

Basically, section one is a _Hello World_ equivalent and section 2 is an example of a workable transaction solution by a familiar database-like query syntax. 

Reference: [Developer Tutorial for creating a Hyperledger Composer solution](https://hyperledger.github.io/composer/tutorials/developer-tutorial.html "Developer Tutorial for creating a Hyperledger Composer solution") and [Queries Tutorial using the Composer Query language and REST APIs](https://hyperledger.github.io/composer/tutorials/queries.html "Queries Tutorial using the Composer Query language and REST APIs")

## Section 1: Hello world!

### Part 0: Installation

See [Hyperledger Composer README file][HC].

### Part 1: Generate a Composer skeleton

![][img1]

Ran on terminal on the development folder path with: `yo hyperledger-composer:businessnetwork`.

### Part 2: Writing the actors and definations

Class defination. Model everything what the Composer need to know about.

[See the tutorial-network/models/org.acme.biznet.cto file](./tutorial-network/models/org.acme.biznet.cto).

[Reference for writing .cto modeling language](https://hyperledger.github.io/composer/reference/cto_language.html).

[Another reference regarding `o` (owned characteristic) and `-->` (has-a relationship) in .cto modeling language](https://stackoverflow.com/a/44410656)

### Part 3: Define how everything works

The logic and communication between the objects defined by the `.cto`.

[See the tutorial-network/lib/logic.js file](./tutorial-network/lib/logic.js).

Do note that this is usually strictly to program-side of thinking. To make the program react based on user input, see the query (`.qry`) file instead (not covered here for obvious reason of unnecessary complexity to demostrate application deployability).

### Part 4: Who can do this?

Access control list on who on what network can do what. Usefulness varies.

[See the tutorial-network/permissions.acl file](./tutorial-network/permissions.acl).

### Part 5: Compile

Compile it to Composer-readable `.bna` (archive) file.

![][img2]

Ran on terminal on the development folder path with: `composer archive create -t dir -n .`.

### Part 6: Deployment

Deployment to the network. Some effort required.

![][img3]

![][img4]

![][img5]

![][img6]

![][rest_server]

Required:-

1. Run/Activate the fabric network (with `./startFabric.sh` in `~/fabric-tools`). Assumed a peer card is available in: `composer card list`.
1. Install Composer network environment for the peer card with: `composer runtime install --card PeerAdmin@hlfv1 --businessNetworkName tutorial-network`.
1. Using the peer card in `tutorial-network` folder, deploy and run application and generate a business network card with: `composer network start --card PeerAdmin@hlfv1 --networkAdmin admin --networkAdminEnrollSecret adminpw --archiveFile tutorial-network@0.0.1.bna --file networkadmin.card`.
1. Import the business network card to the network with: `composer card import --file networkadmin.card`. This is used to communicate with the business network.
1. Testing the application status using the deployed/imported business network card and ping with: `composer network ping --card admin@tutorial-network`.
1. Generate a RESTful server abstraction of the application for the programmers with `composer-rest-server` [do let the terminal process run forever after done configuration].
1. [Before shutdown] Close/Deactivate the fabric network when done (with `./stopFabric.sh` in `~/fabric-tools`). Also, delete the business network card generated with `composer card delete -n admin@tutorial-network`.

Optional:-

1. Check the running fabric processes with `docker ps`.
1. Check the card list available with `composer card list`.

![][img7]

![][img8]

![][img9]

## Section 2: Adding database-like query transaction

### Part 7: Add event to .cto

`event` is used by `queries.qry` later.

### Part 8: Updated lib/logic.js to use event

Updated the logic to apply and use the `event` defined.

### Part 9: Add queries.qry

`queries.qry` contains high-level abstraction query functions for programmers. This allows usage without knowing how everything works on the Composer side, assuming the query does exactly what it was written for.

[See the tutorial-network/queries.qry file](./tutorial-network/queries.qry).

### Part 10: (Re)Creation and (Re)Deployment

Recreate the application and redeploy to the fabric network.

1. (Re)Create the appliction: `composer archive create --sourceType dir --sourceName . -a tutorial-network@0.0.1.bna`
1. Update the network application (if still in network): `composer network update -a tutorial-network@0.0.1.bna -c admin@tutorial-network`
   1. If the application is not in the network, then just deploy.
1. Test the application response in the network: `composer network ping -c admin@tutorial-network`

### Part 11: Testing on REST server in localhost:3000

Test the queries with the REST server in `localhost:3000`.

Refer to the docs for more information.

Do note that since this is a test, information will be lost when the fabric network goes offline.