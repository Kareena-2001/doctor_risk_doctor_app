// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'degree_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DegreeResponseImpl _$$DegreeResponseImplFromJson(Map<String, dynamic> json) =>
    _$DegreeResponseImpl(
      status: json['status'] as bool,
      code: (json['code'] as num).toInt(),
      msg: json['msg'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => DegreeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$DegreeResponseImplToJson(
  _$DegreeResponseImpl instance,
) => <String, dynamic>{
  'status': instance.status,
  'code': instance.code,
  'msg': instance.msg,
  'data': instance.data,
};

_$DegreeModelImpl _$$DegreeModelImplFromJson(Map<String, dynamic> json) =>
    _$DegreeModelImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
    );

Map<String, dynamic> _$$DegreeModelImplToJson(_$DegreeModelImpl instance) =>
    <String, dynamic>{'id': instance.id, 'name': instance.name};
