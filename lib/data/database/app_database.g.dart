// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $CatchesTable extends Catches with TableInfo<$CatchesTable, CatchRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CatchesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _timestampUtcMeta =
      const VerificationMeta('timestampUtc');
  @override
  late final GeneratedColumn<int> timestampUtc = GeneratedColumn<int>(
      'timestamp_utc', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _latitudeMeta =
      const VerificationMeta('latitude');
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
      'latitude', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _longitudeMeta =
      const VerificationMeta('longitude');
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
      'longitude', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _locationSourceMeta =
      const VerificationMeta('locationSource');
  @override
  late final GeneratedColumn<String> locationSource = GeneratedColumn<String>(
      'location_source', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _speciesIdMeta =
      const VerificationMeta('speciesId');
  @override
  late final GeneratedColumn<String> speciesId = GeneratedColumn<String>(
      'species_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sizeClassIdMeta =
      const VerificationMeta('sizeClassId');
  @override
  late final GeneratedColumn<String> sizeClassId = GeneratedColumn<String>(
      'size_class_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _lengthInchesMeta =
      const VerificationMeta('lengthInches');
  @override
  late final GeneratedColumn<double> lengthInches = GeneratedColumn<double>(
      'length_inches', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _weightPoundsMeta =
      const VerificationMeta('weightPounds');
  @override
  late final GeneratedColumn<double> weightPounds = GeneratedColumn<double>(
      'weight_pounds', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _baitOrLureMeta =
      const VerificationMeta('baitOrLure');
  @override
  late final GeneratedColumn<String> baitOrLure = GeneratedColumn<String>(
      'bait_or_lure', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _releasedMeta =
      const VerificationMeta('released');
  @override
  late final GeneratedColumn<bool> released = GeneratedColumn<bool>(
      'released', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("released" IN (0, 1))'));
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _photoLocalPathMeta =
      const VerificationMeta('photoLocalPath');
  @override
  late final GeneratedColumn<String> photoLocalPath = GeneratedColumn<String>(
      'photo_local_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _recommendationPinIdMeta =
      const VerificationMeta('recommendationPinId');
  @override
  late final GeneratedColumn<String> recommendationPinId =
      GeneratedColumn<String>('recommendation_pin_id', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _conditionsJsonMeta =
      const VerificationMeta('conditionsJson');
  @override
  late final GeneratedColumn<String> conditionsJson = GeneratedColumn<String>(
      'conditions_json', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _engineScoreAtCatchMeta =
      const VerificationMeta('engineScoreAtCatch');
  @override
  late final GeneratedColumn<double> engineScoreAtCatch =
      GeneratedColumn<double>('engine_score_at_catch', aliasedName, true,
          type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _engineReasoningJsonMeta =
      const VerificationMeta('engineReasoningJson');
  @override
  late final GeneratedColumn<String> engineReasoningJson =
      GeneratedColumn<String>('engine_reasoning_json', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtUtcMeta =
      const VerificationMeta('createdAtUtc');
  @override
  late final GeneratedColumn<int> createdAtUtc = GeneratedColumn<int>(
      'created_at_utc', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtUtcMeta =
      const VerificationMeta('updatedAtUtc');
  @override
  late final GeneratedColumn<int> updatedAtUtc = GeneratedColumn<int>(
      'updated_at_utc', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _syncStatusMeta =
      const VerificationMeta('syncStatus');
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
      'sync_status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('local'));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        userId,
        timestampUtc,
        latitude,
        longitude,
        locationSource,
        speciesId,
        sizeClassId,
        lengthInches,
        weightPounds,
        baitOrLure,
        released,
        notes,
        photoLocalPath,
        recommendationPinId,
        conditionsJson,
        engineScoreAtCatch,
        engineReasoningJson,
        createdAtUtc,
        updatedAtUtc,
        syncStatus
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'catches';
  @override
  VerificationContext validateIntegrity(Insertable<CatchRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    }
    if (data.containsKey('timestamp_utc')) {
      context.handle(
          _timestampUtcMeta,
          timestampUtc.isAcceptableOrUnknown(
              data['timestamp_utc']!, _timestampUtcMeta));
    } else if (isInserting) {
      context.missing(_timestampUtcMeta);
    }
    if (data.containsKey('latitude')) {
      context.handle(_latitudeMeta,
          latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta));
    } else if (isInserting) {
      context.missing(_latitudeMeta);
    }
    if (data.containsKey('longitude')) {
      context.handle(_longitudeMeta,
          longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta));
    } else if (isInserting) {
      context.missing(_longitudeMeta);
    }
    if (data.containsKey('location_source')) {
      context.handle(
          _locationSourceMeta,
          locationSource.isAcceptableOrUnknown(
              data['location_source']!, _locationSourceMeta));
    } else if (isInserting) {
      context.missing(_locationSourceMeta);
    }
    if (data.containsKey('species_id')) {
      context.handle(_speciesIdMeta,
          speciesId.isAcceptableOrUnknown(data['species_id']!, _speciesIdMeta));
    } else if (isInserting) {
      context.missing(_speciesIdMeta);
    }
    if (data.containsKey('size_class_id')) {
      context.handle(
          _sizeClassIdMeta,
          sizeClassId.isAcceptableOrUnknown(
              data['size_class_id']!, _sizeClassIdMeta));
    }
    if (data.containsKey('length_inches')) {
      context.handle(
          _lengthInchesMeta,
          lengthInches.isAcceptableOrUnknown(
              data['length_inches']!, _lengthInchesMeta));
    }
    if (data.containsKey('weight_pounds')) {
      context.handle(
          _weightPoundsMeta,
          weightPounds.isAcceptableOrUnknown(
              data['weight_pounds']!, _weightPoundsMeta));
    }
    if (data.containsKey('bait_or_lure')) {
      context.handle(
          _baitOrLureMeta,
          baitOrLure.isAcceptableOrUnknown(
              data['bait_or_lure']!, _baitOrLureMeta));
    }
    if (data.containsKey('released')) {
      context.handle(_releasedMeta,
          released.isAcceptableOrUnknown(data['released']!, _releasedMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('photo_local_path')) {
      context.handle(
          _photoLocalPathMeta,
          photoLocalPath.isAcceptableOrUnknown(
              data['photo_local_path']!, _photoLocalPathMeta));
    }
    if (data.containsKey('recommendation_pin_id')) {
      context.handle(
          _recommendationPinIdMeta,
          recommendationPinId.isAcceptableOrUnknown(
              data['recommendation_pin_id']!, _recommendationPinIdMeta));
    }
    if (data.containsKey('conditions_json')) {
      context.handle(
          _conditionsJsonMeta,
          conditionsJson.isAcceptableOrUnknown(
              data['conditions_json']!, _conditionsJsonMeta));
    } else if (isInserting) {
      context.missing(_conditionsJsonMeta);
    }
    if (data.containsKey('engine_score_at_catch')) {
      context.handle(
          _engineScoreAtCatchMeta,
          engineScoreAtCatch.isAcceptableOrUnknown(
              data['engine_score_at_catch']!, _engineScoreAtCatchMeta));
    }
    if (data.containsKey('engine_reasoning_json')) {
      context.handle(
          _engineReasoningJsonMeta,
          engineReasoningJson.isAcceptableOrUnknown(
              data['engine_reasoning_json']!, _engineReasoningJsonMeta));
    }
    if (data.containsKey('created_at_utc')) {
      context.handle(
          _createdAtUtcMeta,
          createdAtUtc.isAcceptableOrUnknown(
              data['created_at_utc']!, _createdAtUtcMeta));
    } else if (isInserting) {
      context.missing(_createdAtUtcMeta);
    }
    if (data.containsKey('updated_at_utc')) {
      context.handle(
          _updatedAtUtcMeta,
          updatedAtUtc.isAcceptableOrUnknown(
              data['updated_at_utc']!, _updatedAtUtcMeta));
    } else if (isInserting) {
      context.missing(_updatedAtUtcMeta);
    }
    if (data.containsKey('sync_status')) {
      context.handle(
          _syncStatusMeta,
          syncStatus.isAcceptableOrUnknown(
              data['sync_status']!, _syncStatusMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CatchRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CatchRow(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id']),
      timestampUtc: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}timestamp_utc'])!,
      latitude: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}latitude'])!,
      longitude: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}longitude'])!,
      locationSource: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}location_source'])!,
      speciesId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}species_id'])!,
      sizeClassId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}size_class_id']),
      lengthInches: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}length_inches']),
      weightPounds: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}weight_pounds']),
      baitOrLure: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}bait_or_lure']),
      released: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}released']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      photoLocalPath: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}photo_local_path']),
      recommendationPinId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}recommendation_pin_id']),
      conditionsJson: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}conditions_json'])!,
      engineScoreAtCatch: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}engine_score_at_catch']),
      engineReasoningJson: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}engine_reasoning_json']),
      createdAtUtc: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}created_at_utc'])!,
      updatedAtUtc: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}updated_at_utc'])!,
      syncStatus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_status'])!,
    );
  }

  @override
  $CatchesTable createAlias(String alias) {
    return $CatchesTable(attachedDatabase, alias);
  }
}

class CatchRow extends DataClass implements Insertable<CatchRow> {
  final String id;
  final String? userId;
  final int timestampUtc;
  final double latitude;
  final double longitude;
  final String locationSource;
  final String speciesId;
  final String? sizeClassId;
  final double? lengthInches;
  final double? weightPounds;
  final String? baitOrLure;
  final bool? released;
  final String? notes;
  final String? photoLocalPath;
  final String? recommendationPinId;
  final String conditionsJson;
  final double? engineScoreAtCatch;
  final String? engineReasoningJson;
  final int createdAtUtc;
  final int updatedAtUtc;
  final String syncStatus;
  const CatchRow(
      {required this.id,
      this.userId,
      required this.timestampUtc,
      required this.latitude,
      required this.longitude,
      required this.locationSource,
      required this.speciesId,
      this.sizeClassId,
      this.lengthInches,
      this.weightPounds,
      this.baitOrLure,
      this.released,
      this.notes,
      this.photoLocalPath,
      this.recommendationPinId,
      required this.conditionsJson,
      this.engineScoreAtCatch,
      this.engineReasoningJson,
      required this.createdAtUtc,
      required this.updatedAtUtc,
      required this.syncStatus});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<String>(userId);
    }
    map['timestamp_utc'] = Variable<int>(timestampUtc);
    map['latitude'] = Variable<double>(latitude);
    map['longitude'] = Variable<double>(longitude);
    map['location_source'] = Variable<String>(locationSource);
    map['species_id'] = Variable<String>(speciesId);
    if (!nullToAbsent || sizeClassId != null) {
      map['size_class_id'] = Variable<String>(sizeClassId);
    }
    if (!nullToAbsent || lengthInches != null) {
      map['length_inches'] = Variable<double>(lengthInches);
    }
    if (!nullToAbsent || weightPounds != null) {
      map['weight_pounds'] = Variable<double>(weightPounds);
    }
    if (!nullToAbsent || baitOrLure != null) {
      map['bait_or_lure'] = Variable<String>(baitOrLure);
    }
    if (!nullToAbsent || released != null) {
      map['released'] = Variable<bool>(released);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || photoLocalPath != null) {
      map['photo_local_path'] = Variable<String>(photoLocalPath);
    }
    if (!nullToAbsent || recommendationPinId != null) {
      map['recommendation_pin_id'] = Variable<String>(recommendationPinId);
    }
    map['conditions_json'] = Variable<String>(conditionsJson);
    if (!nullToAbsent || engineScoreAtCatch != null) {
      map['engine_score_at_catch'] = Variable<double>(engineScoreAtCatch);
    }
    if (!nullToAbsent || engineReasoningJson != null) {
      map['engine_reasoning_json'] = Variable<String>(engineReasoningJson);
    }
    map['created_at_utc'] = Variable<int>(createdAtUtc);
    map['updated_at_utc'] = Variable<int>(updatedAtUtc);
    map['sync_status'] = Variable<String>(syncStatus);
    return map;
  }

  CatchesCompanion toCompanion(bool nullToAbsent) {
    return CatchesCompanion(
      id: Value(id),
      userId:
          userId == null && nullToAbsent ? const Value.absent() : Value(userId),
      timestampUtc: Value(timestampUtc),
      latitude: Value(latitude),
      longitude: Value(longitude),
      locationSource: Value(locationSource),
      speciesId: Value(speciesId),
      sizeClassId: sizeClassId == null && nullToAbsent
          ? const Value.absent()
          : Value(sizeClassId),
      lengthInches: lengthInches == null && nullToAbsent
          ? const Value.absent()
          : Value(lengthInches),
      weightPounds: weightPounds == null && nullToAbsent
          ? const Value.absent()
          : Value(weightPounds),
      baitOrLure: baitOrLure == null && nullToAbsent
          ? const Value.absent()
          : Value(baitOrLure),
      released: released == null && nullToAbsent
          ? const Value.absent()
          : Value(released),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      photoLocalPath: photoLocalPath == null && nullToAbsent
          ? const Value.absent()
          : Value(photoLocalPath),
      recommendationPinId: recommendationPinId == null && nullToAbsent
          ? const Value.absent()
          : Value(recommendationPinId),
      conditionsJson: Value(conditionsJson),
      engineScoreAtCatch: engineScoreAtCatch == null && nullToAbsent
          ? const Value.absent()
          : Value(engineScoreAtCatch),
      engineReasoningJson: engineReasoningJson == null && nullToAbsent
          ? const Value.absent()
          : Value(engineReasoningJson),
      createdAtUtc: Value(createdAtUtc),
      updatedAtUtc: Value(updatedAtUtc),
      syncStatus: Value(syncStatus),
    );
  }

  factory CatchRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CatchRow(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String?>(json['userId']),
      timestampUtc: serializer.fromJson<int>(json['timestampUtc']),
      latitude: serializer.fromJson<double>(json['latitude']),
      longitude: serializer.fromJson<double>(json['longitude']),
      locationSource: serializer.fromJson<String>(json['locationSource']),
      speciesId: serializer.fromJson<String>(json['speciesId']),
      sizeClassId: serializer.fromJson<String?>(json['sizeClassId']),
      lengthInches: serializer.fromJson<double?>(json['lengthInches']),
      weightPounds: serializer.fromJson<double?>(json['weightPounds']),
      baitOrLure: serializer.fromJson<String?>(json['baitOrLure']),
      released: serializer.fromJson<bool?>(json['released']),
      notes: serializer.fromJson<String?>(json['notes']),
      photoLocalPath: serializer.fromJson<String?>(json['photoLocalPath']),
      recommendationPinId:
          serializer.fromJson<String?>(json['recommendationPinId']),
      conditionsJson: serializer.fromJson<String>(json['conditionsJson']),
      engineScoreAtCatch:
          serializer.fromJson<double?>(json['engineScoreAtCatch']),
      engineReasoningJson:
          serializer.fromJson<String?>(json['engineReasoningJson']),
      createdAtUtc: serializer.fromJson<int>(json['createdAtUtc']),
      updatedAtUtc: serializer.fromJson<int>(json['updatedAtUtc']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String?>(userId),
      'timestampUtc': serializer.toJson<int>(timestampUtc),
      'latitude': serializer.toJson<double>(latitude),
      'longitude': serializer.toJson<double>(longitude),
      'locationSource': serializer.toJson<String>(locationSource),
      'speciesId': serializer.toJson<String>(speciesId),
      'sizeClassId': serializer.toJson<String?>(sizeClassId),
      'lengthInches': serializer.toJson<double?>(lengthInches),
      'weightPounds': serializer.toJson<double?>(weightPounds),
      'baitOrLure': serializer.toJson<String?>(baitOrLure),
      'released': serializer.toJson<bool?>(released),
      'notes': serializer.toJson<String?>(notes),
      'photoLocalPath': serializer.toJson<String?>(photoLocalPath),
      'recommendationPinId': serializer.toJson<String?>(recommendationPinId),
      'conditionsJson': serializer.toJson<String>(conditionsJson),
      'engineScoreAtCatch': serializer.toJson<double?>(engineScoreAtCatch),
      'engineReasoningJson': serializer.toJson<String?>(engineReasoningJson),
      'createdAtUtc': serializer.toJson<int>(createdAtUtc),
      'updatedAtUtc': serializer.toJson<int>(updatedAtUtc),
      'syncStatus': serializer.toJson<String>(syncStatus),
    };
  }

  CatchRow copyWith(
          {String? id,
          Value<String?> userId = const Value.absent(),
          int? timestampUtc,
          double? latitude,
          double? longitude,
          String? locationSource,
          String? speciesId,
          Value<String?> sizeClassId = const Value.absent(),
          Value<double?> lengthInches = const Value.absent(),
          Value<double?> weightPounds = const Value.absent(),
          Value<String?> baitOrLure = const Value.absent(),
          Value<bool?> released = const Value.absent(),
          Value<String?> notes = const Value.absent(),
          Value<String?> photoLocalPath = const Value.absent(),
          Value<String?> recommendationPinId = const Value.absent(),
          String? conditionsJson,
          Value<double?> engineScoreAtCatch = const Value.absent(),
          Value<String?> engineReasoningJson = const Value.absent(),
          int? createdAtUtc,
          int? updatedAtUtc,
          String? syncStatus}) =>
      CatchRow(
        id: id ?? this.id,
        userId: userId.present ? userId.value : this.userId,
        timestampUtc: timestampUtc ?? this.timestampUtc,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        locationSource: locationSource ?? this.locationSource,
        speciesId: speciesId ?? this.speciesId,
        sizeClassId: sizeClassId.present ? sizeClassId.value : this.sizeClassId,
        lengthInches:
            lengthInches.present ? lengthInches.value : this.lengthInches,
        weightPounds:
            weightPounds.present ? weightPounds.value : this.weightPounds,
        baitOrLure: baitOrLure.present ? baitOrLure.value : this.baitOrLure,
        released: released.present ? released.value : this.released,
        notes: notes.present ? notes.value : this.notes,
        photoLocalPath:
            photoLocalPath.present ? photoLocalPath.value : this.photoLocalPath,
        recommendationPinId: recommendationPinId.present
            ? recommendationPinId.value
            : this.recommendationPinId,
        conditionsJson: conditionsJson ?? this.conditionsJson,
        engineScoreAtCatch: engineScoreAtCatch.present
            ? engineScoreAtCatch.value
            : this.engineScoreAtCatch,
        engineReasoningJson: engineReasoningJson.present
            ? engineReasoningJson.value
            : this.engineReasoningJson,
        createdAtUtc: createdAtUtc ?? this.createdAtUtc,
        updatedAtUtc: updatedAtUtc ?? this.updatedAtUtc,
        syncStatus: syncStatus ?? this.syncStatus,
      );
  CatchRow copyWithCompanion(CatchesCompanion data) {
    return CatchRow(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      timestampUtc: data.timestampUtc.present
          ? data.timestampUtc.value
          : this.timestampUtc,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      locationSource: data.locationSource.present
          ? data.locationSource.value
          : this.locationSource,
      speciesId: data.speciesId.present ? data.speciesId.value : this.speciesId,
      sizeClassId:
          data.sizeClassId.present ? data.sizeClassId.value : this.sizeClassId,
      lengthInches: data.lengthInches.present
          ? data.lengthInches.value
          : this.lengthInches,
      weightPounds: data.weightPounds.present
          ? data.weightPounds.value
          : this.weightPounds,
      baitOrLure:
          data.baitOrLure.present ? data.baitOrLure.value : this.baitOrLure,
      released: data.released.present ? data.released.value : this.released,
      notes: data.notes.present ? data.notes.value : this.notes,
      photoLocalPath: data.photoLocalPath.present
          ? data.photoLocalPath.value
          : this.photoLocalPath,
      recommendationPinId: data.recommendationPinId.present
          ? data.recommendationPinId.value
          : this.recommendationPinId,
      conditionsJson: data.conditionsJson.present
          ? data.conditionsJson.value
          : this.conditionsJson,
      engineScoreAtCatch: data.engineScoreAtCatch.present
          ? data.engineScoreAtCatch.value
          : this.engineScoreAtCatch,
      engineReasoningJson: data.engineReasoningJson.present
          ? data.engineReasoningJson.value
          : this.engineReasoningJson,
      createdAtUtc: data.createdAtUtc.present
          ? data.createdAtUtc.value
          : this.createdAtUtc,
      updatedAtUtc: data.updatedAtUtc.present
          ? data.updatedAtUtc.value
          : this.updatedAtUtc,
      syncStatus:
          data.syncStatus.present ? data.syncStatus.value : this.syncStatus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CatchRow(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('timestampUtc: $timestampUtc, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('locationSource: $locationSource, ')
          ..write('speciesId: $speciesId, ')
          ..write('sizeClassId: $sizeClassId, ')
          ..write('lengthInches: $lengthInches, ')
          ..write('weightPounds: $weightPounds, ')
          ..write('baitOrLure: $baitOrLure, ')
          ..write('released: $released, ')
          ..write('notes: $notes, ')
          ..write('photoLocalPath: $photoLocalPath, ')
          ..write('recommendationPinId: $recommendationPinId, ')
          ..write('conditionsJson: $conditionsJson, ')
          ..write('engineScoreAtCatch: $engineScoreAtCatch, ')
          ..write('engineReasoningJson: $engineReasoningJson, ')
          ..write('createdAtUtc: $createdAtUtc, ')
          ..write('updatedAtUtc: $updatedAtUtc, ')
          ..write('syncStatus: $syncStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
        id,
        userId,
        timestampUtc,
        latitude,
        longitude,
        locationSource,
        speciesId,
        sizeClassId,
        lengthInches,
        weightPounds,
        baitOrLure,
        released,
        notes,
        photoLocalPath,
        recommendationPinId,
        conditionsJson,
        engineScoreAtCatch,
        engineReasoningJson,
        createdAtUtc,
        updatedAtUtc,
        syncStatus
      ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CatchRow &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.timestampUtc == this.timestampUtc &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.locationSource == this.locationSource &&
          other.speciesId == this.speciesId &&
          other.sizeClassId == this.sizeClassId &&
          other.lengthInches == this.lengthInches &&
          other.weightPounds == this.weightPounds &&
          other.baitOrLure == this.baitOrLure &&
          other.released == this.released &&
          other.notes == this.notes &&
          other.photoLocalPath == this.photoLocalPath &&
          other.recommendationPinId == this.recommendationPinId &&
          other.conditionsJson == this.conditionsJson &&
          other.engineScoreAtCatch == this.engineScoreAtCatch &&
          other.engineReasoningJson == this.engineReasoningJson &&
          other.createdAtUtc == this.createdAtUtc &&
          other.updatedAtUtc == this.updatedAtUtc &&
          other.syncStatus == this.syncStatus);
}

class CatchesCompanion extends UpdateCompanion<CatchRow> {
  final Value<String> id;
  final Value<String?> userId;
  final Value<int> timestampUtc;
  final Value<double> latitude;
  final Value<double> longitude;
  final Value<String> locationSource;
  final Value<String> speciesId;
  final Value<String?> sizeClassId;
  final Value<double?> lengthInches;
  final Value<double?> weightPounds;
  final Value<String?> baitOrLure;
  final Value<bool?> released;
  final Value<String?> notes;
  final Value<String?> photoLocalPath;
  final Value<String?> recommendationPinId;
  final Value<String> conditionsJson;
  final Value<double?> engineScoreAtCatch;
  final Value<String?> engineReasoningJson;
  final Value<int> createdAtUtc;
  final Value<int> updatedAtUtc;
  final Value<String> syncStatus;
  final Value<int> rowid;
  const CatchesCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.timestampUtc = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.locationSource = const Value.absent(),
    this.speciesId = const Value.absent(),
    this.sizeClassId = const Value.absent(),
    this.lengthInches = const Value.absent(),
    this.weightPounds = const Value.absent(),
    this.baitOrLure = const Value.absent(),
    this.released = const Value.absent(),
    this.notes = const Value.absent(),
    this.photoLocalPath = const Value.absent(),
    this.recommendationPinId = const Value.absent(),
    this.conditionsJson = const Value.absent(),
    this.engineScoreAtCatch = const Value.absent(),
    this.engineReasoningJson = const Value.absent(),
    this.createdAtUtc = const Value.absent(),
    this.updatedAtUtc = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CatchesCompanion.insert({
    required String id,
    this.userId = const Value.absent(),
    required int timestampUtc,
    required double latitude,
    required double longitude,
    required String locationSource,
    required String speciesId,
    this.sizeClassId = const Value.absent(),
    this.lengthInches = const Value.absent(),
    this.weightPounds = const Value.absent(),
    this.baitOrLure = const Value.absent(),
    this.released = const Value.absent(),
    this.notes = const Value.absent(),
    this.photoLocalPath = const Value.absent(),
    this.recommendationPinId = const Value.absent(),
    required String conditionsJson,
    this.engineScoreAtCatch = const Value.absent(),
    this.engineReasoningJson = const Value.absent(),
    required int createdAtUtc,
    required int updatedAtUtc,
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        timestampUtc = Value(timestampUtc),
        latitude = Value(latitude),
        longitude = Value(longitude),
        locationSource = Value(locationSource),
        speciesId = Value(speciesId),
        conditionsJson = Value(conditionsJson),
        createdAtUtc = Value(createdAtUtc),
        updatedAtUtc = Value(updatedAtUtc);
  static Insertable<CatchRow> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<int>? timestampUtc,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<String>? locationSource,
    Expression<String>? speciesId,
    Expression<String>? sizeClassId,
    Expression<double>? lengthInches,
    Expression<double>? weightPounds,
    Expression<String>? baitOrLure,
    Expression<bool>? released,
    Expression<String>? notes,
    Expression<String>? photoLocalPath,
    Expression<String>? recommendationPinId,
    Expression<String>? conditionsJson,
    Expression<double>? engineScoreAtCatch,
    Expression<String>? engineReasoningJson,
    Expression<int>? createdAtUtc,
    Expression<int>? updatedAtUtc,
    Expression<String>? syncStatus,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (timestampUtc != null) 'timestamp_utc': timestampUtc,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (locationSource != null) 'location_source': locationSource,
      if (speciesId != null) 'species_id': speciesId,
      if (sizeClassId != null) 'size_class_id': sizeClassId,
      if (lengthInches != null) 'length_inches': lengthInches,
      if (weightPounds != null) 'weight_pounds': weightPounds,
      if (baitOrLure != null) 'bait_or_lure': baitOrLure,
      if (released != null) 'released': released,
      if (notes != null) 'notes': notes,
      if (photoLocalPath != null) 'photo_local_path': photoLocalPath,
      if (recommendationPinId != null)
        'recommendation_pin_id': recommendationPinId,
      if (conditionsJson != null) 'conditions_json': conditionsJson,
      if (engineScoreAtCatch != null)
        'engine_score_at_catch': engineScoreAtCatch,
      if (engineReasoningJson != null)
        'engine_reasoning_json': engineReasoningJson,
      if (createdAtUtc != null) 'created_at_utc': createdAtUtc,
      if (updatedAtUtc != null) 'updated_at_utc': updatedAtUtc,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CatchesCompanion copyWith(
      {Value<String>? id,
      Value<String?>? userId,
      Value<int>? timestampUtc,
      Value<double>? latitude,
      Value<double>? longitude,
      Value<String>? locationSource,
      Value<String>? speciesId,
      Value<String?>? sizeClassId,
      Value<double?>? lengthInches,
      Value<double?>? weightPounds,
      Value<String?>? baitOrLure,
      Value<bool?>? released,
      Value<String?>? notes,
      Value<String?>? photoLocalPath,
      Value<String?>? recommendationPinId,
      Value<String>? conditionsJson,
      Value<double?>? engineScoreAtCatch,
      Value<String?>? engineReasoningJson,
      Value<int>? createdAtUtc,
      Value<int>? updatedAtUtc,
      Value<String>? syncStatus,
      Value<int>? rowid}) {
    return CatchesCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      timestampUtc: timestampUtc ?? this.timestampUtc,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      locationSource: locationSource ?? this.locationSource,
      speciesId: speciesId ?? this.speciesId,
      sizeClassId: sizeClassId ?? this.sizeClassId,
      lengthInches: lengthInches ?? this.lengthInches,
      weightPounds: weightPounds ?? this.weightPounds,
      baitOrLure: baitOrLure ?? this.baitOrLure,
      released: released ?? this.released,
      notes: notes ?? this.notes,
      photoLocalPath: photoLocalPath ?? this.photoLocalPath,
      recommendationPinId: recommendationPinId ?? this.recommendationPinId,
      conditionsJson: conditionsJson ?? this.conditionsJson,
      engineScoreAtCatch: engineScoreAtCatch ?? this.engineScoreAtCatch,
      engineReasoningJson: engineReasoningJson ?? this.engineReasoningJson,
      createdAtUtc: createdAtUtc ?? this.createdAtUtc,
      updatedAtUtc: updatedAtUtc ?? this.updatedAtUtc,
      syncStatus: syncStatus ?? this.syncStatus,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (timestampUtc.present) {
      map['timestamp_utc'] = Variable<int>(timestampUtc.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (locationSource.present) {
      map['location_source'] = Variable<String>(locationSource.value);
    }
    if (speciesId.present) {
      map['species_id'] = Variable<String>(speciesId.value);
    }
    if (sizeClassId.present) {
      map['size_class_id'] = Variable<String>(sizeClassId.value);
    }
    if (lengthInches.present) {
      map['length_inches'] = Variable<double>(lengthInches.value);
    }
    if (weightPounds.present) {
      map['weight_pounds'] = Variable<double>(weightPounds.value);
    }
    if (baitOrLure.present) {
      map['bait_or_lure'] = Variable<String>(baitOrLure.value);
    }
    if (released.present) {
      map['released'] = Variable<bool>(released.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (photoLocalPath.present) {
      map['photo_local_path'] = Variable<String>(photoLocalPath.value);
    }
    if (recommendationPinId.present) {
      map['recommendation_pin_id'] =
          Variable<String>(recommendationPinId.value);
    }
    if (conditionsJson.present) {
      map['conditions_json'] = Variable<String>(conditionsJson.value);
    }
    if (engineScoreAtCatch.present) {
      map['engine_score_at_catch'] = Variable<double>(engineScoreAtCatch.value);
    }
    if (engineReasoningJson.present) {
      map['engine_reasoning_json'] =
          Variable<String>(engineReasoningJson.value);
    }
    if (createdAtUtc.present) {
      map['created_at_utc'] = Variable<int>(createdAtUtc.value);
    }
    if (updatedAtUtc.present) {
      map['updated_at_utc'] = Variable<int>(updatedAtUtc.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CatchesCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('timestampUtc: $timestampUtc, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('locationSource: $locationSource, ')
          ..write('speciesId: $speciesId, ')
          ..write('sizeClassId: $sizeClassId, ')
          ..write('lengthInches: $lengthInches, ')
          ..write('weightPounds: $weightPounds, ')
          ..write('baitOrLure: $baitOrLure, ')
          ..write('released: $released, ')
          ..write('notes: $notes, ')
          ..write('photoLocalPath: $photoLocalPath, ')
          ..write('recommendationPinId: $recommendationPinId, ')
          ..write('conditionsJson: $conditionsJson, ')
          ..write('engineScoreAtCatch: $engineScoreAtCatch, ')
          ..write('engineReasoningJson: $engineReasoningJson, ')
          ..write('createdAtUtc: $createdAtUtc, ')
          ..write('updatedAtUtc: $updatedAtUtc, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CatchesTable catches = $CatchesTable(this);
  late final CatchesDao catchesDao = CatchesDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [catches];
}

typedef $$CatchesTableCreateCompanionBuilder = CatchesCompanion Function({
  required String id,
  Value<String?> userId,
  required int timestampUtc,
  required double latitude,
  required double longitude,
  required String locationSource,
  required String speciesId,
  Value<String?> sizeClassId,
  Value<double?> lengthInches,
  Value<double?> weightPounds,
  Value<String?> baitOrLure,
  Value<bool?> released,
  Value<String?> notes,
  Value<String?> photoLocalPath,
  Value<String?> recommendationPinId,
  required String conditionsJson,
  Value<double?> engineScoreAtCatch,
  Value<String?> engineReasoningJson,
  required int createdAtUtc,
  required int updatedAtUtc,
  Value<String> syncStatus,
  Value<int> rowid,
});
typedef $$CatchesTableUpdateCompanionBuilder = CatchesCompanion Function({
  Value<String> id,
  Value<String?> userId,
  Value<int> timestampUtc,
  Value<double> latitude,
  Value<double> longitude,
  Value<String> locationSource,
  Value<String> speciesId,
  Value<String?> sizeClassId,
  Value<double?> lengthInches,
  Value<double?> weightPounds,
  Value<String?> baitOrLure,
  Value<bool?> released,
  Value<String?> notes,
  Value<String?> photoLocalPath,
  Value<String?> recommendationPinId,
  Value<String> conditionsJson,
  Value<double?> engineScoreAtCatch,
  Value<String?> engineReasoningJson,
  Value<int> createdAtUtc,
  Value<int> updatedAtUtc,
  Value<String> syncStatus,
  Value<int> rowid,
});

class $$CatchesTableFilterComposer
    extends Composer<_$AppDatabase, $CatchesTable> {
  $$CatchesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get timestampUtc => $composableBuilder(
      column: $table.timestampUtc, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get latitude => $composableBuilder(
      column: $table.latitude, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get longitude => $composableBuilder(
      column: $table.longitude, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get locationSource => $composableBuilder(
      column: $table.locationSource,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get speciesId => $composableBuilder(
      column: $table.speciesId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get sizeClassId => $composableBuilder(
      column: $table.sizeClassId, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get lengthInches => $composableBuilder(
      column: $table.lengthInches, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get weightPounds => $composableBuilder(
      column: $table.weightPounds, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get baitOrLure => $composableBuilder(
      column: $table.baitOrLure, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get released => $composableBuilder(
      column: $table.released, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get photoLocalPath => $composableBuilder(
      column: $table.photoLocalPath,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get recommendationPinId => $composableBuilder(
      column: $table.recommendationPinId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get conditionsJson => $composableBuilder(
      column: $table.conditionsJson,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get engineScoreAtCatch => $composableBuilder(
      column: $table.engineScoreAtCatch,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get engineReasoningJson => $composableBuilder(
      column: $table.engineReasoningJson,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get createdAtUtc => $composableBuilder(
      column: $table.createdAtUtc, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get updatedAtUtc => $composableBuilder(
      column: $table.updatedAtUtc, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnFilters(column));
}

class $$CatchesTableOrderingComposer
    extends Composer<_$AppDatabase, $CatchesTable> {
  $$CatchesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get timestampUtc => $composableBuilder(
      column: $table.timestampUtc,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get latitude => $composableBuilder(
      column: $table.latitude, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get longitude => $composableBuilder(
      column: $table.longitude, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get locationSource => $composableBuilder(
      column: $table.locationSource,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get speciesId => $composableBuilder(
      column: $table.speciesId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get sizeClassId => $composableBuilder(
      column: $table.sizeClassId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get lengthInches => $composableBuilder(
      column: $table.lengthInches,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get weightPounds => $composableBuilder(
      column: $table.weightPounds,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get baitOrLure => $composableBuilder(
      column: $table.baitOrLure, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get released => $composableBuilder(
      column: $table.released, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get photoLocalPath => $composableBuilder(
      column: $table.photoLocalPath,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get recommendationPinId => $composableBuilder(
      column: $table.recommendationPinId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get conditionsJson => $composableBuilder(
      column: $table.conditionsJson,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get engineScoreAtCatch => $composableBuilder(
      column: $table.engineScoreAtCatch,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get engineReasoningJson => $composableBuilder(
      column: $table.engineReasoningJson,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get createdAtUtc => $composableBuilder(
      column: $table.createdAtUtc,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get updatedAtUtc => $composableBuilder(
      column: $table.updatedAtUtc,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnOrderings(column));
}

class $$CatchesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CatchesTable> {
  $$CatchesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<int> get timestampUtc => $composableBuilder(
      column: $table.timestampUtc, builder: (column) => column);

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<String> get locationSource => $composableBuilder(
      column: $table.locationSource, builder: (column) => column);

  GeneratedColumn<String> get speciesId =>
      $composableBuilder(column: $table.speciesId, builder: (column) => column);

  GeneratedColumn<String> get sizeClassId => $composableBuilder(
      column: $table.sizeClassId, builder: (column) => column);

  GeneratedColumn<double> get lengthInches => $composableBuilder(
      column: $table.lengthInches, builder: (column) => column);

  GeneratedColumn<double> get weightPounds => $composableBuilder(
      column: $table.weightPounds, builder: (column) => column);

  GeneratedColumn<String> get baitOrLure => $composableBuilder(
      column: $table.baitOrLure, builder: (column) => column);

  GeneratedColumn<bool> get released =>
      $composableBuilder(column: $table.released, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get photoLocalPath => $composableBuilder(
      column: $table.photoLocalPath, builder: (column) => column);

  GeneratedColumn<String> get recommendationPinId => $composableBuilder(
      column: $table.recommendationPinId, builder: (column) => column);

  GeneratedColumn<String> get conditionsJson => $composableBuilder(
      column: $table.conditionsJson, builder: (column) => column);

  GeneratedColumn<double> get engineScoreAtCatch => $composableBuilder(
      column: $table.engineScoreAtCatch, builder: (column) => column);

  GeneratedColumn<String> get engineReasoningJson => $composableBuilder(
      column: $table.engineReasoningJson, builder: (column) => column);

  GeneratedColumn<int> get createdAtUtc => $composableBuilder(
      column: $table.createdAtUtc, builder: (column) => column);

  GeneratedColumn<int> get updatedAtUtc => $composableBuilder(
      column: $table.updatedAtUtc, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => column);
}

class $$CatchesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CatchesTable,
    CatchRow,
    $$CatchesTableFilterComposer,
    $$CatchesTableOrderingComposer,
    $$CatchesTableAnnotationComposer,
    $$CatchesTableCreateCompanionBuilder,
    $$CatchesTableUpdateCompanionBuilder,
    (CatchRow, BaseReferences<_$AppDatabase, $CatchesTable, CatchRow>),
    CatchRow,
    PrefetchHooks Function()> {
  $$CatchesTableTableManager(_$AppDatabase db, $CatchesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CatchesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CatchesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CatchesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String?> userId = const Value.absent(),
            Value<int> timestampUtc = const Value.absent(),
            Value<double> latitude = const Value.absent(),
            Value<double> longitude = const Value.absent(),
            Value<String> locationSource = const Value.absent(),
            Value<String> speciesId = const Value.absent(),
            Value<String?> sizeClassId = const Value.absent(),
            Value<double?> lengthInches = const Value.absent(),
            Value<double?> weightPounds = const Value.absent(),
            Value<String?> baitOrLure = const Value.absent(),
            Value<bool?> released = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<String?> photoLocalPath = const Value.absent(),
            Value<String?> recommendationPinId = const Value.absent(),
            Value<String> conditionsJson = const Value.absent(),
            Value<double?> engineScoreAtCatch = const Value.absent(),
            Value<String?> engineReasoningJson = const Value.absent(),
            Value<int> createdAtUtc = const Value.absent(),
            Value<int> updatedAtUtc = const Value.absent(),
            Value<String> syncStatus = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CatchesCompanion(
            id: id,
            userId: userId,
            timestampUtc: timestampUtc,
            latitude: latitude,
            longitude: longitude,
            locationSource: locationSource,
            speciesId: speciesId,
            sizeClassId: sizeClassId,
            lengthInches: lengthInches,
            weightPounds: weightPounds,
            baitOrLure: baitOrLure,
            released: released,
            notes: notes,
            photoLocalPath: photoLocalPath,
            recommendationPinId: recommendationPinId,
            conditionsJson: conditionsJson,
            engineScoreAtCatch: engineScoreAtCatch,
            engineReasoningJson: engineReasoningJson,
            createdAtUtc: createdAtUtc,
            updatedAtUtc: updatedAtUtc,
            syncStatus: syncStatus,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            Value<String?> userId = const Value.absent(),
            required int timestampUtc,
            required double latitude,
            required double longitude,
            required String locationSource,
            required String speciesId,
            Value<String?> sizeClassId = const Value.absent(),
            Value<double?> lengthInches = const Value.absent(),
            Value<double?> weightPounds = const Value.absent(),
            Value<String?> baitOrLure = const Value.absent(),
            Value<bool?> released = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<String?> photoLocalPath = const Value.absent(),
            Value<String?> recommendationPinId = const Value.absent(),
            required String conditionsJson,
            Value<double?> engineScoreAtCatch = const Value.absent(),
            Value<String?> engineReasoningJson = const Value.absent(),
            required int createdAtUtc,
            required int updatedAtUtc,
            Value<String> syncStatus = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CatchesCompanion.insert(
            id: id,
            userId: userId,
            timestampUtc: timestampUtc,
            latitude: latitude,
            longitude: longitude,
            locationSource: locationSource,
            speciesId: speciesId,
            sizeClassId: sizeClassId,
            lengthInches: lengthInches,
            weightPounds: weightPounds,
            baitOrLure: baitOrLure,
            released: released,
            notes: notes,
            photoLocalPath: photoLocalPath,
            recommendationPinId: recommendationPinId,
            conditionsJson: conditionsJson,
            engineScoreAtCatch: engineScoreAtCatch,
            engineReasoningJson: engineReasoningJson,
            createdAtUtc: createdAtUtc,
            updatedAtUtc: updatedAtUtc,
            syncStatus: syncStatus,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$CatchesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CatchesTable,
    CatchRow,
    $$CatchesTableFilterComposer,
    $$CatchesTableOrderingComposer,
    $$CatchesTableAnnotationComposer,
    $$CatchesTableCreateCompanionBuilder,
    $$CatchesTableUpdateCompanionBuilder,
    (CatchRow, BaseReferences<_$AppDatabase, $CatchesTable, CatchRow>),
    CatchRow,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CatchesTableTableManager get catches =>
      $$CatchesTableTableManager(_db, _db.catches);
}
