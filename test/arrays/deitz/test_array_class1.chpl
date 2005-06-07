class MyDomainInfo {
  var low : integer;
  var high : integer;
  var stride : integer;
  var alignment : integer;
}

class MyDomain {
  parameter rank : integer;
  var info : _data = _data(MyDomainInfo);
  function init() {
    info.alloc(rank, "domain info");
  }
  function dimInit(d : integer, low, high, stride) {
    info(d-1).low = low;
    info(d-1).high = high;
    info(d-1).stride = stride;
    info(d-1).alignment = info(d-1).stride;
  }
}

var D : MyDomain = MyDomain(rank=2);
D.init();
D.dimInit(1, 1, 8, 1);
D.dimInit(2, 1, 16, 1);
writeln(D);

/*
class MyArrayInfo {
  var off : integer;
  var blk : integer;
}

class MyArray {
  type elementType;
  type domainType;
  parameter rank : integer;
  var _domain : domainType;
  var info : _data = _data(MyArrayInfo);
  var data : _data = _data(elementType);
}
*/
