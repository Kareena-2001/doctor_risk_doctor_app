// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'holiday_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HolidayStateImpl _$$HolidayStateImplFromJson(Map<String, dynamic> json) =>
    _$HolidayStateImpl(
      errorListMessage: json['errorListMessage'] as String?,
      isLoadingList: json['isLoadingList'] as bool? ?? false,
      holidayList:
          (json['holidayList'] as List<dynamic>?)
              ?.map((e) => HolidayData.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$HolidayStateImplToJson(_$HolidayStateImpl instance) =>
    <String, dynamic>{
      'errorListMessage': instance.errorListMessage,
      'isLoadingList': instance.isLoadingList,
      'holidayList': instance.holidayList,
    };
