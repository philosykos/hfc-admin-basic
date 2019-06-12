/*
Copyright IBM Corp. 2016 All Rights Reserved.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

		 http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

package main

//WARNING - this chaincode's ID is hard-coded in chaincode_example04 to illustrate one way of
//calling chaincode from a chaincode. If this example is modified, chaincode_example04.go has
//to be modified as well with the new ID of chaincode_example02.
//chaincode_example05 show's how chaincode ID can be passed in as a parameter instead of
//hard-coding.

import (
	"encoding/json"
	"fmt"
	"strconv"

	"github.com/hyperledger/fabric/core/chaincode/shim"
	pb "github.com/hyperledger/fabric/protos/peer"
)

type User struct {
	UserId  string  `json:"userId"`
	Balance float64 `json:"balance"`
}

// SimpleChaincode example simple Chaincode implementation
type SimpleChaincode struct {
}

func (t *SimpleChaincode) Init(stub shim.ChaincodeStubInterface) pb.Response {
	fmt.Println("ex02 Init")
	_, args := stub.GetFunctionAndParameters()
	var A, B User // Entities
	var err error

	if len(args) != 4 {
		return shim.Error("Incorrect number of arguments. Expecting 4")
	}

	// Initialize the chaincode
	A.UserId = args[0]
	A.Balance, err = strconv.ParseFloat(args[1], 64)
	if err != nil {
		return shim.Error("Expecting integer value for asset holding")
	}
	B.UserId = args[2]
	B.Balance, err = strconv.ParseFloat(args[3], 64)
	if err != nil {
		return shim.Error("Expecting integer value for asset holding")
	}

	aJsonBytes, err := json.Marshal(A)
	bJsonBytes, err := json.Marshal(B)

	// Write the state to the ledger
	err = stub.PutState(A.UserId, aJsonBytes)
	if err != nil {
		return shim.Error(err.Error())
	}

	err = stub.PutState(B.UserId, bJsonBytes)
	if err != nil {
		return shim.Error(err.Error())
	}

	return shim.Success(nil)
}

func (t *SimpleChaincode) Invoke(stub shim.ChaincodeStubInterface) pb.Response {
	fmt.Println("ex02 Invoke")
	function, args := stub.GetFunctionAndParameters()
	if function == "invoke" {
		// Make payment of X units from A to B
		return t.invoke(stub, args)
	} else if function == "delete" {
		// Deletes an entity from its state
		return t.delete(stub, args)
	} else if function == "query" {
		// the old "Query" is now implemtned in invoke
		return t.query(stub, args)
	}

	return shim.Error("Invalid invoke function name. Expecting \"invoke\" \"delete\" \"query\"")
}

// A, B, 10
// A, B, C, 100 -> B 0.3 C 0.7
// Transaction makes payment of X units from A to B
func (t *SimpleChaincode) invoke(stub shim.ChaincodeStubInterface, args []string) pb.Response {
	var A, B, C User // Entities
	var X float64    // Transaction value
	var err error

	if len(args) != 4 {
		return shim.Error("Incorrect number of arguments. Expecting 4")
	}

	A.UserId = args[0]
	B.UserId = args[1]
	C.UserId = args[2]
	X, err = strconv.ParseFloat(args[3], 64)
	if err != nil {
		return shim.Error("The points must be integer type.")
	}
	if X < 0 {
		return shim.Error("point must be greater than 0")
	}

	// Get the state from the ledger
	Avalbytes, err := stub.GetState(A.UserId)
	json.Unmarshal(Avalbytes, &A)

	if err != nil {
		return shim.Error("Failed to get state")
	}
	if Avalbytes == nil {
		return shim.Error("Entity not found")
	}

	Bvalbytes, err := stub.GetState(B.UserId)
	json.Unmarshal(Bvalbytes, &B)
	if err != nil {
		return shim.Error("Failed to get state")
	}
	if Bvalbytes == nil {
		return shim.Error("Entity not found")
	}

	Cvalbytes, err := stub.GetState(C.UserId)
	if err != nil {
		return shim.Error("Failed to get state")
	}
	if Cvalbytes != nil {
		json.Unmarshal(Cvalbytes, &C)
	}	

	A.Balance = A.Balance - X
	B.Balance = B.Balance + X*0.3
	C.Balance = C.Balance + X*0.7

	aJsonBytes, err := json.Marshal(A)
	bJsonBytes, err := json.Marshal(B)
	cJsonBytes, err := json.Marshal(C)

	// Write the state back to the ledger
	err = stub.PutState(A.UserId, aJsonBytes)
	if err != nil {
		return shim.Error(err.Error())
	}

	err = stub.PutState(B.UserId, bJsonBytes)
	if err != nil {
		return shim.Error(err.Error())
	}

	err = stub.PutState(C.UserId, cJsonBytes)
	if err != nil {
		return shim.Error(err.Error())
	}

	return shim.Success(nil)
}

// Deletes an entity from state
func (t *SimpleChaincode) delete(stub shim.ChaincodeStubInterface, args []string) pb.Response {
	if len(args) != 1 {
		return shim.Error("Incorrect number of arguments. Expecting 1")
	}

	A := args[0]

	// Delete the key from the state in ledger
	err := stub.DelState(A)
	if err != nil {
		return shim.Error("Failed to delete state")
	}

	return shim.Success(nil)
}

// query callback representing the query of a chaincode
func (t *SimpleChaincode) query(stub shim.ChaincodeStubInterface, args []string) pb.Response {
	var A User // Entities
	var err error

	if len(args) != 1 {
		return shim.Error("Incorrect number of arguments. Expecting name of the person to query")
	}

	A.UserId = args[0]

	// Get the state from the ledger
	Avalbytes, err := stub.GetState(A.UserId)
	if err != nil {
		jsonResp := "{\"Error\":\"Failed to get state for " + A.UserId + "\"}"
		return shim.Error(jsonResp)
	}

	if Avalbytes == nil {
		jsonResp := "{\"Error\":\"Nil amount for " + A.UserId + "\"}"
		return shim.Error(jsonResp)
	}

	return shim.Success(Avalbytes)
}

func main() {
	err := shim.Start(new(SimpleChaincode))
	if err != nil {
		fmt.Printf("Error starting Simple chaincode: %s", err)
	}
}
