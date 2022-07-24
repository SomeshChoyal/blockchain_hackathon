//SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract userLogin {
    uint256 num = 0;
   uint256 userID;
   string userPass;

  //  string userName;

    uint256[] mobnum;
   // uint256 [] userdonations;
    struct logIn {
        uint256 userID;
        string userPass;
        
        
    }
    struct logIn2 {
        uint256 userID;

        string userName;

    }
    
    mapping(string => uint256) private idtopass;
    
    mapping(uint256 => string) public idtoname;


    logIn[] public login;
    
    logIn2[] public login2;
    

    function addperson(
        string memory _userPass,
        string memory _name
        
    ) public {
        userID=num;
         login.push(logIn( userID, _userPass));
         
         login2.push(logIn2( userID, _name));
         

        idtopass[_userPass] = userID;
        idtoname[userID]= _name;
//mobnum[userID]= _mobnum;
      //  userdonations[userID] = 0;
        num++;
    }

    //to compare strings
    function equals(string memory a, string memory b)
        public
        pure
        returns (bool)
    {
        if (bytes(a).length != bytes(b).length) {
            return false;
        } else {
            return
                keccak256(abi.encodePacked(a)) ==
                keccak256(abi.encodePacked(b));
        }
    }

    // function show(uint256 _userID) view public returns(string memory) {
    //idtopass[_userID];
    //return idtopass[_userID];
    function userlogin(uint256 _userID, string memory _userPass)
        public
        view
        returns (
            string memory,
            
            
            uint256
        )
    {
        //bool a = equals(idtopass[_userPass], _userID);
        string memory b = "enter valid id and passward";

        
        //uint256 d;
        uint256 e;

        if (idtopass[_userPass]==_userID) {
          b= idtoname[_userID];
          //d=userdonations[_userID];
          //e=mobnum[_userID];
//e= userPass;
            return (b,  e);
        } else return (b,   e);
    }
}