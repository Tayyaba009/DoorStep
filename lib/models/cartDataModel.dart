class CartDataModel{
  //data Type
  String? id;
  String? p_id;
  String? ptitle;
  String? uprice;
  String? qnty;
  String? tprice;
  String? image;

// constructor
  CartDataModel(
      {
        this.id,
        this.p_id,
        this.ptitle,
        this.uprice,
        this.qnty,
        this.tprice,
        this.image,

        }
      );

  //method that assign values to respective datatype vairables
  CartDataModel.fromJson(Map<String,dynamic> json)
  {
    id = json['id'];
    p_id =json['p_id'];
    ptitle = json['ptitle'];
    uprice = json['uprice'];
    qnty = json['qnty'];
    tprice = json['tprice'];
    image = json['image'];

  }

  Map<String,dynamic> Json()=>{
    "id":id,
    "p_id":p_id,
    "ptitle":ptitle,
    "uprice":uprice,
    "qnty":qnty,
    "tprice":tprice,
    "image":image,

  };
}