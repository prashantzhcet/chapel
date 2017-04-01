/*
 *  Generic Stack
 *
 *  This example implements a generic stack data structure using an array. 
 *
 */

// A stack class that is generic over the type of data that it
// contains.  This implementation uses an array to store the elements
// in the stack.
record Stack {
  type itemType;            // type of items
  var numItems: int = 0;    // number of items in the stack
  var dataSpace: domain(1) = {1..2};
  var data: [dataSpace] itemType; // array of items

  // push method: add an item to the top of the stack
  // note: the array is doubled if it is full
  proc push(item: itemType) {
    var height = data.numElements;
    if numItems == height then
      dataSpace = {1..height*2};
    data(numItems+1) = item;
    numItems += 1;
  }

  // pop method: remove an item from the top of the stack
  // note: it is a runtime error if the stack is empty
  proc pop() {
    if isEmpty then
      halt("attempt to pop an item off an empty stack");
    numItems -= 1;
    return data(numItems+1);
  }

  // isEmpty method: true if the stack is empty; otherwise false
  proc isEmpty return numItems == 0;
}
