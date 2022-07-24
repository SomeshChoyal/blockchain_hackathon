//SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract creatorLogin {
    uint256 num = 0;
   uint256 creatorID;
   string creatorPass;

  //  string userName;

    uint256[] mobnum;
   // uint256 [] userdonations;
    struct logIn {
        uint256 creatorID;
        string creatorPass;
        
        
    }
    struct logIn2 {
        uint256 creatorID;

        string creatorName;

    }
    
    mapping(uint256 => string) private idtopass;
    
    mapping(uint256 => string) private idtoname;


    logIn[] public login;
    
    logIn2[] public login2;
    

    function addperson(
        string memory _creatorPass,
        string memory _name
        
        
    ) public {
        creatorID=num;
         login.push(logIn( creatorID, _creatorPass));
         
         login2.push(logIn2( creatorID, _name));
         

        idtopass[creatorID] = _creatorPass;
        idtoname[creatorID]= _name;
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
    function creatorlogin(uint256 _creatorID, string memory _creatorPass)
        public
        view
        returns (
            string memory,
            
            
            uint256
        )
    {
        bool a = equals(idtopass[_creatorID], _creatorPass);
        string memory b = "enter valid id and passward";

        
        //uint256 d;
        uint256 e;

        if (a == true) {
          b= idtoname[_creatorID];
          //d=userdonations[_userID];
          //e=mobnum[_userID];
//e= userPass;
            return (b,  e);
        } else return (b,   e);
    }
}
