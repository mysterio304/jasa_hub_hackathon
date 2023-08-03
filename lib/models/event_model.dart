class EventModel{
  String? id;
  String? name;
  String? date;
  String? type;
  String? level;
  int? cost;
  bool? isOpen;
  String? url;


  EventModel({this.id, this.name, this.date, this.type, this.level, this.cost, this.isOpen, this.url});



  factory EventModel.fromMap(map){
    return EventModel(
      id: map['id'],
      name: map['name'],
      date: map['date'],
      type: map['type'],
      level: map['level'],
      cost: map['cost'],
      isOpen: map['isOpen'],
      url: map['url'],
    );
  }



  Map<String, dynamic> toMap(){
    return{
      'id': id,
      'name': name,
      'date': date,
      'type': type,
      'level': level,
      'cost': cost,
      'isOpen': isOpen,
      'url': url,
    };
  }
}