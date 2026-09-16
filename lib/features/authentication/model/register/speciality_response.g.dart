// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'speciality_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SpecialityResponseImpl _$$SpecialityResponseImplFromJson(
  Map<String, dynamic> json,
) => _$SpecialityResponseImpl(
  status: json['status'] as bool,
  code: (json['code'] as num).toInt(),
  msg: json['msg'] as String,
  data: (json['data'] as List<dynamic>)
      .map((e) => SpecialityModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$$SpecialityResponseImplToJson(
  _$SpecialityResponseImpl instance,
) => <String, dynamic>{
  'status': instance.status,
  'code': instance.code,
  'msg': instance.msg,
  'data': instance.data,
};

_$SpecialityModelImpl _$$SpecialityModelImplFromJson(
  Map<String, dynamic> json,
) => _$SpecialityModelImpl(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
);

Map<String, dynamic> _$$SpecialityModelImplToJson(
  _$SpecialityModelImpl instance,
) => <String, dynamic>{'id': instance.id, 'name': instance.name};
