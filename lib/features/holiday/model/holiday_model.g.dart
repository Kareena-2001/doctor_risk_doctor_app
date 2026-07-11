// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'holiday_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HolidayResponseImpl _$$HolidayResponseImplFromJson(
  Map<String, dynamic> json,
) => _$HolidayResponseImpl(
  status: (json['status'] as num).toInt(),
  message: json['msg'] as String,
  data: (json['data'] as List<dynamic>)
      .map((e) => HolidayData.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$$HolidayResponseImplToJson(
  _$HolidayResponseImpl instance,
) => <String, dynamic>{
  'status': instance.status,
  'msg': instance.message,
  'data': instance.data,
};

_$HolidayDataImpl _$$HolidayDataImplFromJson(Map<String, dynamic> json) =>
    _$HolidayDataImpl(
      title: json['title'] as String,
      holidayDate: json['holiday_date'] as String,
    );

Map<String, dynamic> _$$HolidayDataImplToJson(_$HolidayDataImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'holiday_date': instance.holidayDate,
    };
