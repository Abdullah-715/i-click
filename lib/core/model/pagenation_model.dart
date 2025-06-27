class PagenationModel {
  final int? startFrom, limitCount, totalCount;

  PagenationModel({this.startFrom, this.limitCount,  this.totalCount});



  factory PagenationModel.fromJson(Map<String, dynamic> json) {
    return PagenationModel(
      limitCount: json['limit_count'],
      totalCount: json['total_count'],
      startFrom: json['start_from']
    );
  }


}
