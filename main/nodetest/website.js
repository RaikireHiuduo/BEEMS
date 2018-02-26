var express = require('express');
var app = express();
var router = express.Router();

//Body-parser & Mysql packages
var bodyParser = require('body-parser');
var mysql = require('mysql');

//EJS
// set the view engine to ejs
app.set('view engine', 'ejs');

// create application/x-www-form-urlencoded parser
var urlencodedParser = bodyParser.urlencoded({ extended: false });
var jsonParser = bodyParser.json();

//Create mysql connection
var db = mysql.createConnection({
	host     : 'localhost',
	user     : 'root',
	password : '',
	database : 'nodetest'
});

//Connects to mysql db
db.connect(function(err){
	//Throw error
	if(err){
		throw err;
	}
	console.log ('Database connected!');
});

//Set view path 
// __dirname is syntax for current directory  
var viewPath = __dirname + '/views/'; 
  
app.use('/',router);

//Get index.html 
router.get('/',function(req, res){
  res.render(viewPath + 'index');
}); 


/* -------------------------------------- Assets Routes  ---------------------------------------- */
//Get addasset page
//This page is to add new asset 
router.get('/addAsset',function(req, res){
  res.render(viewPath + 'addasset');
});

//Post addasset
router.post('/addAsset',urlencodedParser,function(req, res){
	if (!req.body) return res.sendStatus(400);	//Error

	//Insert into Database via Mysql
	var sql = "INSERT INTO assets (Name, Type, Description) VALUES ('"+ req.body.itemName +"', '"+ req.body.itemType +"', '"+ req.body.itemDesc +"')";
 	
 	db.query(sql, function (err, result) {
    	if (err) {
    		throw err;
    	} 
    	console.log("1 record inserted");
  	});

	res.redirect(req.get('referer')); //Go back to location where request made
});

router.get('/manageAsset',function(req, res){

    var obj = {};
    //Get data from mysql
    db.query('SELECT * FROM assets', function(err, result) {
    	
        if(err){
            throw err;
        }

       	obj = {print: result}; 
        res.render(viewPath + 'manageasset', obj);
        //console.log(obj);  
        //console.log('Succesfully generate data table.');              
    });	
});

//Fetch asset data for datatable in Asset tab
app.post('/fetchAsset',jsonParser, function(req, res){
	db.query('SELECT * FROM assets WHERE ID = ' + req.body.assetID + ';', function(err, result) {
    	
        if(err){
            throw err;
        }
    //console.log(result);
    res.send(result);             
    });	
	
});

router.post('/updateAsset',jsonParser,function(req, res){
	if (!req.body) return res.sendStatus(400);	//Error
    
    //console.log(req.body);
	//Update Database via Mysql
	var sql = "UPDATE assets SET Name='" + req.body.name + "', Type = '" + req.body.type + "', Description = '" + req.body.description + "' WHERE ID = " + req.body.assetID;
 	
 	db.query(sql, function (err, result) {
    if (err) {
    		throw err;
    } 
    //console.log("1 record updated");
    res.send(result); 
  	});	
});

//Delete account data
app.post('/deleteAsset',jsonParser, function(req, res){

	db.query('DELETE FROM assets WHERE ID = ' + req.body.assetID + ';', function(err, result) {
    	//console.log(req.body.accountID);
        if(err){
            throw err;
        }
    //console.log(result);
    res.send(result);             
    });	
	
});


/* ---------------------------------------- Account / User Routes  ---------------------------------------- */
//Get signup page
//This page is for account registration
router.get('/addAccount',function(req, res){
  res.render(viewPath + 'adduser');
});

//POST signup
router.post('/addAccount',urlencodedParser,function(req, res){
	//Insert into Database via Mysql
	var sql = "INSERT INTO account (username, password) VALUES ('"+ req.body.username +"', '"+ req.body.password + "')";
 	
 	db.query(sql, function (err, result) {
    	if (err) {
    		throw err;
    	} 
    	console.log("1 record inserted");
  	});

	res.redirect(req.get('referer')); //Go back to location where request made
});

//Get Manage Account page
//This page is to manage asset data 

router.get('/manageAccount',function(req, res){

    var obj = {};
    //Get data from mysql
    db.query('SELECT * FROM account', function(err, result) {
    	
        if(err){
            throw err;
        }

       	obj = {print: result}; 
        res.render(viewPath + 'manageacc', obj);
        //console.log(obj);  
        //console.log('Succesfully generate data table.');              
    });	
});

//Fetch account data for datatable in Account tab
app.post('/fetchAccount',jsonParser, function(req, res){
	db.query('SELECT * FROM account WHERE ID = ' + req.body.accountID + ';', function(err, result) {
    	
        if(err){
            throw err;
        }
    //console.log(result);
    res.send(result);             
    });	
	
});

router.post('/updateAccount',jsonParser,function(req, res){
	if (!req.body) return res.sendStatus(400);	//Error
    
    //console.log(req.body);
	//Update Database via Mysql
	var sql = "UPDATE account SET username='"+ req.body.username +"', password = '"+ req.body.password +"' WHERE ID = " + req.body.accountID;
 	
 	db.query(sql, function (err, result) {
    if (err) {
    		throw err;
    } 
    //console.log("1 record updated");
    res.send(result); 
  	});

	
});

//Delete account data
app.post('/deleteAccount',jsonParser, function(req, res){

	db.query('DELETE FROM account WHERE ID = ' + req.body.accountID + ';', function(err, result) {
    	//console.log(req.body.accountID);
        if(err){
            throw err;
        }

    //console.log(result);
    res.send(result);             
    });	
	
});


/* ---------------------------------------- About US  ---------------------------------------- */
//About Us Page
router.get('/aboutUs',function(req, res){
  res.render(viewPath + 'aboutus');
});


/* -------------------------------- Exception Handling / Others  ---------------------------------- */
//Exception Handling 
//When route is on any other than the above, error404 is displayed
app.use('*',function(req, res){
  res.send('Error 404: Not Found!');
});

//Listening to port 3000
app.listen(3000, function () {
	console.log('Server listening on port 3000!');
});