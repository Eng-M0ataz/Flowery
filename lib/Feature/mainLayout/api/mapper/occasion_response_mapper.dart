import 'package:flower_e_commerce_app/Feature/mainLayout/api/mapper/meta_data_mapper.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/api/mapper/occasion_mapper.dart';
import '../../domain/entities/meta_data_entity.dart';
import '../../domain/entities/response/occasion_response_entity.dart';
import '../models/response/occasion_response_dto.dart';

extension OccasionResponseDtoMapper on OccasionResponseDto {
  OccasionResponseEntity toEntity() {
    return OccasionResponseEntity(
      message: message ?? 'No message',
      metadata: metadata?.toEntity() ??
          MetadataEntity(
            currentPage: 1,
            totalPages: 1,
            limit: 0,
            totalItems: 0,
          ),
      occasions: occasions?.map((e) => e.toEntity()).toList() ?? [],
    );
  }
}
