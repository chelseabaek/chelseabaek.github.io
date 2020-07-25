<%@ Page Language="C#" Inherits="aroundU.Default" %>
<!DOCTYPE html>
<html lang="en">
    
<head>
    <title>aroundU</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="style.css">
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="storeInfo.js"></script>
    <script> 
        $(function(){
            $("#navbarReuse").load("navbarReuse.html"); 
            $("#storeReuse").load("storeReuse.html");
            $("#pharmacyReuse").load("pharmacyReuse.html");
            $("#aboutUs").load("aboutUs.html");
            $("#contactUs").load("contactUs.html");
            $("#footerReuse").load("footerReuse.html");
        });         
    </script> 
    <style> 
    #map { 
    height: 400px; 
    width: 100%; 
    } 
    </style>
</head>

<body>
        
<!-- Google Map script
    <div id="map"></div> 

    <script> 
      function initMap() { 
        var test= {lat: 45.508888, lng: -73.561668}; 
        var map = new google.maps.Map(document.getElementById('map'), { 
          zoom: 4, 
          center: test 
        }); 
        var marker = new google.maps.Marker({ 
          position: test, 
          map: map 
        }); 
      } 
    </script> 
    <script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyC7gkfYem-5rLdai9P1hC0cxWIrmh1dUb4&callback=initMap"></script>         
-->
        
    <div id="navbarReuse"></div>
        
    <div class="jumbotron text-center">
        <a href="#searchWrapper">
            <img src="images/logo.png" alt="AROUNDULOGO" class="myLogo">
        </a>
        <div class="myText" style="color:#ffffff;"><p style="font-size:3vh">in association with DDQIC</p></div>   
    </div>

<!-- switch b/w grocery and pharmacy       
    <div class="container">  
        <ul class="nav nav-pills nav-justified">
            <li class="active"><a data-toggle="pill" href="#groceries"><h5><b>Groceries</b></h5></a></li>
            <li><a data-toggle="pill" href="#pharms"><h5><b>Pharmacies</b></h5></a></li>
        </ul>
        <br>
        <div class="tab-content">
            <div id="groceries" class="tab-pane fade in active">
                <div class="container-fluid"> 
                    <div class="container-fluid">
                        <div id="searchWrapper">
                            <input
                                type="text"
                                name="searchBar"
                                id="searchBar"
                                placeholder="Search for a grocery store"
                            />
                        </div>
                        <br>
                    </div>
                    <div id="storesList">                  
                    </div>
                </div>
            </div>
            <div id="pharms" class="tab-pane fade">
                <div class="container-fluid">
                    <div class="row">                        
                        <div id="pharmacyReuse">
                        </div>                          
                    </div>
                </div>
            </div>
        </div>
    </div>
-->
        
    <div class="container">    
        <div class="container-fluid"> 
            <div class="container-fluid">
                <div id="searchWrapper">
                    <input
                        type="text"
                        name="searchBar"
                        id="searchBar"
                        placeholder="Search for a store"
                    />
                </div>
                <br>
            </div>
            <div id="storesList">                  
            </div>
        </div>
    </div>

    <div class="container" id="here">  
        <ul class="nav nav-tabs nav-justified">
            <li class="active"><a data-toggle="pill" href="#aboutUsInfo"><h5><b>About Us</b></h5></a></li>
            <li><a data-toggle="pill" href="#contactUsInfo"><h5><b>Contact Us</b></h5></a></li>
        </ul>
         <div class="tab-content">
            <div id="aboutUsInfo" class="tab-pane fade in active">
                <div class="container-fluid">  
                    <div class="row">
                        <div id="aboutUs"></div>
                    </div>
                </div>
            </div>
            <div id="contactUsInfo" class="tab-pane fade">
                <div class="container-fluid">
                    <div class="row">                        
                        <div id="contactUs"></div>                          
                    </div>
                </div>
            </div>
        </div>
    </div>       
        
    <div id="footerReuse"></div>
    
    <!-- search bar and modal script for stores -->
    <script>
        const storesList = document.getElementById('storesList');
        const searchBar = document.getElementById('searchBar');
        let allStores = [];

        searchBar.addEventListener('keyup', (e) => {
            const searchString = e.target.value.toLowerCase();

            const filteredStores = allStores.filter((store) => {
                return (
                    store.name.toLowerCase().includes(searchString)||store.address.toLowerCase().includes(searchString)
                );
            });
            displayStores(filteredStores);
        });

        const loadStores = async () => {
            try {
                const res = await fetch('groceryList.json');
                allStores = await res.json();
                displayStores(allStores);
            } catch (err) {
                console.error(err);
            }
        };

        const displayStores = (stores) => {
            const htmlString = stores
                .map((store) => {
                    return `   
                    <a data-toggle="modal" data-target="#myModal${store.ID}">
                        <div class="row">
                            <div class="col-sm-12" id="stores">                            
                                <p style="font-size: 30px;">${store.name}
                                <img id="storeImage" src="${store.image}" style="float:right" width="90px" height="auto" >
                                <p>${store.address}</p>       
                                </p>
                                
                             </div>                        
                        </div>
                    </a>
                    
                    <!-- Modal -->
                    <div id="myModal${store.ID}" class="modal fade" role="dialog">
                      <div class="modal-dialog modal-lg">

                        <!-- Modal content-->
                        <div class="modal-content">
                          <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h2 class="modal-title"><center>${store.name}</center></h2>
                          </div>
                          <div class="modal-body">
                            <div class="row">
                                <div class="col-sm-12">
                                    <h3>Capacity</h3>
                                    <hr style="height:2px;border-width:0;color:#e26a6b;background-color:#e26a6b">
                                    <br>
                                    <br>
                                    <br>
                                    <br>   
                                    <br>
                                    <br>
                                    <br>
                                    <br>
                                    <h3>Past Trends</h3>
                                    <hr style="height:2px;border-width:0;color:#e26a6b;background-color:#e26a6b">
                                    <br>
                                    <br>
                                    <br>
                                    <br>   
                                    <br>
                                    <br>
                                    <br>
                                    <br>  
                                    <img id="storeImage" src="${store.image}" style="float:right" width="90px" height="auto" >    
                                    <h4>${store.name}</h4>
                                    <h5><a style="color: black"; href="${store.map}" target="_blank" rel="noopener"><span class="glyphicon glyphicon-map-marker"></span>&nbsp;${store.address}</a></h5>   
                                    <h5><a style="color: black"; href="${store.website}" target="_blank" rel="noopener"><span class="glyphicon glyphicon-globe"></span>&nbsp;${store.website}</a></h5>
                                </div>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                    <br>
                `;
                })
                .join('');
            storesList.innerHTML = htmlString;
        };     
         
        loadStores();          
    </script> 
        
        
</body>   
</html>
