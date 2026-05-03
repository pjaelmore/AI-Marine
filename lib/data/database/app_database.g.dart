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

class $TripPlansTable extends TripPlans
    with TableInfo<$TripPlansTable, TripPlanRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TripPlansTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _boundsSwLatMeta =
      const VerificationMeta('boundsSwLat');
  @override
  late final GeneratedColumn<double> boundsSwLat = GeneratedColumn<double>(
      'bounds_sw_lat', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _boundsSwLonMeta =
      const VerificationMeta('boundsSwLon');
  @override
  late final GeneratedColumn<double> boundsSwLon = GeneratedColumn<double>(
      'bounds_sw_lon', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _boundsNeLatMeta =
      const VerificationMeta('boundsNeLat');
  @override
  late final GeneratedColumn<double> boundsNeLat = GeneratedColumn<double>(
      'bounds_ne_lat', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _boundsNeLonMeta =
      const VerificationMeta('boundsNeLon');
  @override
  late final GeneratedColumn<double> boundsNeLon = GeneratedColumn<double>(
      'bounds_ne_lon', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _plannedStartUtcMeta =
      const VerificationMeta('plannedStartUtc');
  @override
  late final GeneratedColumn<int> plannedStartUtc = GeneratedColumn<int>(
      'planned_start_utc', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _plannedEndUtcMeta =
      const VerificationMeta('plannedEndUtc');
  @override
  late final GeneratedColumn<int> plannedEndUtc = GeneratedColumn<int>(
      'planned_end_utc', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _targetSpeciesIdMeta =
      const VerificationMeta('targetSpeciesId');
  @override
  late final GeneratedColumn<String> targetSpeciesId = GeneratedColumn<String>(
      'target_species_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _cacheStatusJsonMeta =
      const VerificationMeta('cacheStatusJson');
  @override
  late final GeneratedColumn<String> cacheStatusJson = GeneratedColumn<String>(
      'cache_status_json', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtUtcMeta =
      const VerificationMeta('createdAtUtc');
  @override
  late final GeneratedColumn<int> createdAtUtc = GeneratedColumn<int>(
      'created_at_utc', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        userId,
        name,
        boundsSwLat,
        boundsSwLon,
        boundsNeLat,
        boundsNeLon,
        plannedStartUtc,
        plannedEndUtc,
        targetSpeciesId,
        cacheStatusJson,
        createdAtUtc
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'trip_plans';
  @override
  VerificationContext validateIntegrity(Insertable<TripPlanRow> instance,
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
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('bounds_sw_lat')) {
      context.handle(
          _boundsSwLatMeta,
          boundsSwLat.isAcceptableOrUnknown(
              data['bounds_sw_lat']!, _boundsSwLatMeta));
    } else if (isInserting) {
      context.missing(_boundsSwLatMeta);
    }
    if (data.containsKey('bounds_sw_lon')) {
      context.handle(
          _boundsSwLonMeta,
          boundsSwLon.isAcceptableOrUnknown(
              data['bounds_sw_lon']!, _boundsSwLonMeta));
    } else if (isInserting) {
      context.missing(_boundsSwLonMeta);
    }
    if (data.containsKey('bounds_ne_lat')) {
      context.handle(
          _boundsNeLatMeta,
          boundsNeLat.isAcceptableOrUnknown(
              data['bounds_ne_lat']!, _boundsNeLatMeta));
    } else if (isInserting) {
      context.missing(_boundsNeLatMeta);
    }
    if (data.containsKey('bounds_ne_lon')) {
      context.handle(
          _boundsNeLonMeta,
          boundsNeLon.isAcceptableOrUnknown(
              data['bounds_ne_lon']!, _boundsNeLonMeta));
    } else if (isInserting) {
      context.missing(_boundsNeLonMeta);
    }
    if (data.containsKey('planned_start_utc')) {
      context.handle(
          _plannedStartUtcMeta,
          plannedStartUtc.isAcceptableOrUnknown(
              data['planned_start_utc']!, _plannedStartUtcMeta));
    } else if (isInserting) {
      context.missing(_plannedStartUtcMeta);
    }
    if (data.containsKey('planned_end_utc')) {
      context.handle(
          _plannedEndUtcMeta,
          plannedEndUtc.isAcceptableOrUnknown(
              data['planned_end_utc']!, _plannedEndUtcMeta));
    } else if (isInserting) {
      context.missing(_plannedEndUtcMeta);
    }
    if (data.containsKey('target_species_id')) {
      context.handle(
          _targetSpeciesIdMeta,
          targetSpeciesId.isAcceptableOrUnknown(
              data['target_species_id']!, _targetSpeciesIdMeta));
    } else if (isInserting) {
      context.missing(_targetSpeciesIdMeta);
    }
    if (data.containsKey('cache_status_json')) {
      context.handle(
          _cacheStatusJsonMeta,
          cacheStatusJson.isAcceptableOrUnknown(
              data['cache_status_json']!, _cacheStatusJsonMeta));
    } else if (isInserting) {
      context.missing(_cacheStatusJsonMeta);
    }
    if (data.containsKey('created_at_utc')) {
      context.handle(
          _createdAtUtcMeta,
          createdAtUtc.isAcceptableOrUnknown(
              data['created_at_utc']!, _createdAtUtcMeta));
    } else if (isInserting) {
      context.missing(_createdAtUtcMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TripPlanRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TripPlanRow(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id']),
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      boundsSwLat: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}bounds_sw_lat'])!,
      boundsSwLon: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}bounds_sw_lon'])!,
      boundsNeLat: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}bounds_ne_lat'])!,
      boundsNeLon: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}bounds_ne_lon'])!,
      plannedStartUtc: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}planned_start_utc'])!,
      plannedEndUtc: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}planned_end_utc'])!,
      targetSpeciesId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}target_species_id'])!,
      cacheStatusJson: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}cache_status_json'])!,
      createdAtUtc: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}created_at_utc'])!,
    );
  }

  @override
  $TripPlansTable createAlias(String alias) {
    return $TripPlansTable(attachedDatabase, alias);
  }
}

class TripPlanRow extends DataClass implements Insertable<TripPlanRow> {
  final String id;
  final String? userId;
  final String name;
  final double boundsSwLat;
  final double boundsSwLon;
  final double boundsNeLat;
  final double boundsNeLon;
  final int plannedStartUtc;
  final int plannedEndUtc;
  final String targetSpeciesId;
  final String cacheStatusJson;
  final int createdAtUtc;
  const TripPlanRow(
      {required this.id,
      this.userId,
      required this.name,
      required this.boundsSwLat,
      required this.boundsSwLon,
      required this.boundsNeLat,
      required this.boundsNeLon,
      required this.plannedStartUtc,
      required this.plannedEndUtc,
      required this.targetSpeciesId,
      required this.cacheStatusJson,
      required this.createdAtUtc});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<String>(userId);
    }
    map['name'] = Variable<String>(name);
    map['bounds_sw_lat'] = Variable<double>(boundsSwLat);
    map['bounds_sw_lon'] = Variable<double>(boundsSwLon);
    map['bounds_ne_lat'] = Variable<double>(boundsNeLat);
    map['bounds_ne_lon'] = Variable<double>(boundsNeLon);
    map['planned_start_utc'] = Variable<int>(plannedStartUtc);
    map['planned_end_utc'] = Variable<int>(plannedEndUtc);
    map['target_species_id'] = Variable<String>(targetSpeciesId);
    map['cache_status_json'] = Variable<String>(cacheStatusJson);
    map['created_at_utc'] = Variable<int>(createdAtUtc);
    return map;
  }

  TripPlansCompanion toCompanion(bool nullToAbsent) {
    return TripPlansCompanion(
      id: Value(id),
      userId:
          userId == null && nullToAbsent ? const Value.absent() : Value(userId),
      name: Value(name),
      boundsSwLat: Value(boundsSwLat),
      boundsSwLon: Value(boundsSwLon),
      boundsNeLat: Value(boundsNeLat),
      boundsNeLon: Value(boundsNeLon),
      plannedStartUtc: Value(plannedStartUtc),
      plannedEndUtc: Value(plannedEndUtc),
      targetSpeciesId: Value(targetSpeciesId),
      cacheStatusJson: Value(cacheStatusJson),
      createdAtUtc: Value(createdAtUtc),
    );
  }

  factory TripPlanRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TripPlanRow(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String?>(json['userId']),
      name: serializer.fromJson<String>(json['name']),
      boundsSwLat: serializer.fromJson<double>(json['boundsSwLat']),
      boundsSwLon: serializer.fromJson<double>(json['boundsSwLon']),
      boundsNeLat: serializer.fromJson<double>(json['boundsNeLat']),
      boundsNeLon: serializer.fromJson<double>(json['boundsNeLon']),
      plannedStartUtc: serializer.fromJson<int>(json['plannedStartUtc']),
      plannedEndUtc: serializer.fromJson<int>(json['plannedEndUtc']),
      targetSpeciesId: serializer.fromJson<String>(json['targetSpeciesId']),
      cacheStatusJson: serializer.fromJson<String>(json['cacheStatusJson']),
      createdAtUtc: serializer.fromJson<int>(json['createdAtUtc']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String?>(userId),
      'name': serializer.toJson<String>(name),
      'boundsSwLat': serializer.toJson<double>(boundsSwLat),
      'boundsSwLon': serializer.toJson<double>(boundsSwLon),
      'boundsNeLat': serializer.toJson<double>(boundsNeLat),
      'boundsNeLon': serializer.toJson<double>(boundsNeLon),
      'plannedStartUtc': serializer.toJson<int>(plannedStartUtc),
      'plannedEndUtc': serializer.toJson<int>(plannedEndUtc),
      'targetSpeciesId': serializer.toJson<String>(targetSpeciesId),
      'cacheStatusJson': serializer.toJson<String>(cacheStatusJson),
      'createdAtUtc': serializer.toJson<int>(createdAtUtc),
    };
  }

  TripPlanRow copyWith(
          {String? id,
          Value<String?> userId = const Value.absent(),
          String? name,
          double? boundsSwLat,
          double? boundsSwLon,
          double? boundsNeLat,
          double? boundsNeLon,
          int? plannedStartUtc,
          int? plannedEndUtc,
          String? targetSpeciesId,
          String? cacheStatusJson,
          int? createdAtUtc}) =>
      TripPlanRow(
        id: id ?? this.id,
        userId: userId.present ? userId.value : this.userId,
        name: name ?? this.name,
        boundsSwLat: boundsSwLat ?? this.boundsSwLat,
        boundsSwLon: boundsSwLon ?? this.boundsSwLon,
        boundsNeLat: boundsNeLat ?? this.boundsNeLat,
        boundsNeLon: boundsNeLon ?? this.boundsNeLon,
        plannedStartUtc: plannedStartUtc ?? this.plannedStartUtc,
        plannedEndUtc: plannedEndUtc ?? this.plannedEndUtc,
        targetSpeciesId: targetSpeciesId ?? this.targetSpeciesId,
        cacheStatusJson: cacheStatusJson ?? this.cacheStatusJson,
        createdAtUtc: createdAtUtc ?? this.createdAtUtc,
      );
  TripPlanRow copyWithCompanion(TripPlansCompanion data) {
    return TripPlanRow(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      name: data.name.present ? data.name.value : this.name,
      boundsSwLat:
          data.boundsSwLat.present ? data.boundsSwLat.value : this.boundsSwLat,
      boundsSwLon:
          data.boundsSwLon.present ? data.boundsSwLon.value : this.boundsSwLon,
      boundsNeLat:
          data.boundsNeLat.present ? data.boundsNeLat.value : this.boundsNeLat,
      boundsNeLon:
          data.boundsNeLon.present ? data.boundsNeLon.value : this.boundsNeLon,
      plannedStartUtc: data.plannedStartUtc.present
          ? data.plannedStartUtc.value
          : this.plannedStartUtc,
      plannedEndUtc: data.plannedEndUtc.present
          ? data.plannedEndUtc.value
          : this.plannedEndUtc,
      targetSpeciesId: data.targetSpeciesId.present
          ? data.targetSpeciesId.value
          : this.targetSpeciesId,
      cacheStatusJson: data.cacheStatusJson.present
          ? data.cacheStatusJson.value
          : this.cacheStatusJson,
      createdAtUtc: data.createdAtUtc.present
          ? data.createdAtUtc.value
          : this.createdAtUtc,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TripPlanRow(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('name: $name, ')
          ..write('boundsSwLat: $boundsSwLat, ')
          ..write('boundsSwLon: $boundsSwLon, ')
          ..write('boundsNeLat: $boundsNeLat, ')
          ..write('boundsNeLon: $boundsNeLon, ')
          ..write('plannedStartUtc: $plannedStartUtc, ')
          ..write('plannedEndUtc: $plannedEndUtc, ')
          ..write('targetSpeciesId: $targetSpeciesId, ')
          ..write('cacheStatusJson: $cacheStatusJson, ')
          ..write('createdAtUtc: $createdAtUtc')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      userId,
      name,
      boundsSwLat,
      boundsSwLon,
      boundsNeLat,
      boundsNeLon,
      plannedStartUtc,
      plannedEndUtc,
      targetSpeciesId,
      cacheStatusJson,
      createdAtUtc);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TripPlanRow &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.name == this.name &&
          other.boundsSwLat == this.boundsSwLat &&
          other.boundsSwLon == this.boundsSwLon &&
          other.boundsNeLat == this.boundsNeLat &&
          other.boundsNeLon == this.boundsNeLon &&
          other.plannedStartUtc == this.plannedStartUtc &&
          other.plannedEndUtc == this.plannedEndUtc &&
          other.targetSpeciesId == this.targetSpeciesId &&
          other.cacheStatusJson == this.cacheStatusJson &&
          other.createdAtUtc == this.createdAtUtc);
}

class TripPlansCompanion extends UpdateCompanion<TripPlanRow> {
  final Value<String> id;
  final Value<String?> userId;
  final Value<String> name;
  final Value<double> boundsSwLat;
  final Value<double> boundsSwLon;
  final Value<double> boundsNeLat;
  final Value<double> boundsNeLon;
  final Value<int> plannedStartUtc;
  final Value<int> plannedEndUtc;
  final Value<String> targetSpeciesId;
  final Value<String> cacheStatusJson;
  final Value<int> createdAtUtc;
  final Value<int> rowid;
  const TripPlansCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.name = const Value.absent(),
    this.boundsSwLat = const Value.absent(),
    this.boundsSwLon = const Value.absent(),
    this.boundsNeLat = const Value.absent(),
    this.boundsNeLon = const Value.absent(),
    this.plannedStartUtc = const Value.absent(),
    this.plannedEndUtc = const Value.absent(),
    this.targetSpeciesId = const Value.absent(),
    this.cacheStatusJson = const Value.absent(),
    this.createdAtUtc = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TripPlansCompanion.insert({
    required String id,
    this.userId = const Value.absent(),
    required String name,
    required double boundsSwLat,
    required double boundsSwLon,
    required double boundsNeLat,
    required double boundsNeLon,
    required int plannedStartUtc,
    required int plannedEndUtc,
    required String targetSpeciesId,
    required String cacheStatusJson,
    required int createdAtUtc,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        boundsSwLat = Value(boundsSwLat),
        boundsSwLon = Value(boundsSwLon),
        boundsNeLat = Value(boundsNeLat),
        boundsNeLon = Value(boundsNeLon),
        plannedStartUtc = Value(plannedStartUtc),
        plannedEndUtc = Value(plannedEndUtc),
        targetSpeciesId = Value(targetSpeciesId),
        cacheStatusJson = Value(cacheStatusJson),
        createdAtUtc = Value(createdAtUtc);
  static Insertable<TripPlanRow> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<String>? name,
    Expression<double>? boundsSwLat,
    Expression<double>? boundsSwLon,
    Expression<double>? boundsNeLat,
    Expression<double>? boundsNeLon,
    Expression<int>? plannedStartUtc,
    Expression<int>? plannedEndUtc,
    Expression<String>? targetSpeciesId,
    Expression<String>? cacheStatusJson,
    Expression<int>? createdAtUtc,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (name != null) 'name': name,
      if (boundsSwLat != null) 'bounds_sw_lat': boundsSwLat,
      if (boundsSwLon != null) 'bounds_sw_lon': boundsSwLon,
      if (boundsNeLat != null) 'bounds_ne_lat': boundsNeLat,
      if (boundsNeLon != null) 'bounds_ne_lon': boundsNeLon,
      if (plannedStartUtc != null) 'planned_start_utc': plannedStartUtc,
      if (plannedEndUtc != null) 'planned_end_utc': plannedEndUtc,
      if (targetSpeciesId != null) 'target_species_id': targetSpeciesId,
      if (cacheStatusJson != null) 'cache_status_json': cacheStatusJson,
      if (createdAtUtc != null) 'created_at_utc': createdAtUtc,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TripPlansCompanion copyWith(
      {Value<String>? id,
      Value<String?>? userId,
      Value<String>? name,
      Value<double>? boundsSwLat,
      Value<double>? boundsSwLon,
      Value<double>? boundsNeLat,
      Value<double>? boundsNeLon,
      Value<int>? plannedStartUtc,
      Value<int>? plannedEndUtc,
      Value<String>? targetSpeciesId,
      Value<String>? cacheStatusJson,
      Value<int>? createdAtUtc,
      Value<int>? rowid}) {
    return TripPlansCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      boundsSwLat: boundsSwLat ?? this.boundsSwLat,
      boundsSwLon: boundsSwLon ?? this.boundsSwLon,
      boundsNeLat: boundsNeLat ?? this.boundsNeLat,
      boundsNeLon: boundsNeLon ?? this.boundsNeLon,
      plannedStartUtc: plannedStartUtc ?? this.plannedStartUtc,
      plannedEndUtc: plannedEndUtc ?? this.plannedEndUtc,
      targetSpeciesId: targetSpeciesId ?? this.targetSpeciesId,
      cacheStatusJson: cacheStatusJson ?? this.cacheStatusJson,
      createdAtUtc: createdAtUtc ?? this.createdAtUtc,
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
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (boundsSwLat.present) {
      map['bounds_sw_lat'] = Variable<double>(boundsSwLat.value);
    }
    if (boundsSwLon.present) {
      map['bounds_sw_lon'] = Variable<double>(boundsSwLon.value);
    }
    if (boundsNeLat.present) {
      map['bounds_ne_lat'] = Variable<double>(boundsNeLat.value);
    }
    if (boundsNeLon.present) {
      map['bounds_ne_lon'] = Variable<double>(boundsNeLon.value);
    }
    if (plannedStartUtc.present) {
      map['planned_start_utc'] = Variable<int>(plannedStartUtc.value);
    }
    if (plannedEndUtc.present) {
      map['planned_end_utc'] = Variable<int>(plannedEndUtc.value);
    }
    if (targetSpeciesId.present) {
      map['target_species_id'] = Variable<String>(targetSpeciesId.value);
    }
    if (cacheStatusJson.present) {
      map['cache_status_json'] = Variable<String>(cacheStatusJson.value);
    }
    if (createdAtUtc.present) {
      map['created_at_utc'] = Variable<int>(createdAtUtc.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TripPlansCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('name: $name, ')
          ..write('boundsSwLat: $boundsSwLat, ')
          ..write('boundsSwLon: $boundsSwLon, ')
          ..write('boundsNeLat: $boundsNeLat, ')
          ..write('boundsNeLon: $boundsNeLon, ')
          ..write('plannedStartUtc: $plannedStartUtc, ')
          ..write('plannedEndUtc: $plannedEndUtc, ')
          ..write('targetSpeciesId: $targetSpeciesId, ')
          ..write('cacheStatusJson: $cacheStatusJson, ')
          ..write('createdAtUtc: $createdAtUtc, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UserPreferencesTableTable extends UserPreferencesTable
    with TableInfo<$UserPreferencesTableTable, UserPreferencesRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserPreferencesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _homeRegionIdMeta =
      const VerificationMeta('homeRegionId');
  @override
  late final GeneratedColumn<String> homeRegionId = GeneratedColumn<String>(
      'home_region_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _primarySpeciesIdMeta =
      const VerificationMeta('primarySpeciesId');
  @override
  late final GeneratedColumn<String> primarySpeciesId = GeneratedColumn<String>(
      'primary_species_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _unitsMeta = const VerificationMeta('units');
  @override
  late final GeneratedColumn<String> units = GeneratedColumn<String>(
      'units', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('imperial'));
  static const VerificationMeta _privacyOptInAggregateMeta =
      const VerificationMeta('privacyOptInAggregate');
  @override
  late final GeneratedColumn<bool> privacyOptInAggregate =
      GeneratedColumn<bool>('privacy_opt_in_aggregate', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'CHECK ("privacy_opt_in_aggregate" IN (0, 1))'),
          defaultValue: const Constant(false));
  static const VerificationMeta _cacheBudgetMbMeta =
      const VerificationMeta('cacheBudgetMb');
  @override
  late final GeneratedColumn<int> cacheBudgetMb = GeneratedColumn<int>(
      'cache_budget_mb', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(500));
  static const VerificationMeta _useNmea2000WhenAvailableMeta =
      const VerificationMeta('useNmea2000WhenAvailable');
  @override
  late final GeneratedColumn<bool> useNmea2000WhenAvailable =
      GeneratedColumn<bool>(
          'use_nmea2000_when_available', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'CHECK ("use_nmea2000_when_available" IN (0, 1))'),
          defaultValue: const Constant(false));
  static const VerificationMeta _gatewayConfigJsonMeta =
      const VerificationMeta('gatewayConfigJson');
  @override
  late final GeneratedColumn<String> gatewayConfigJson =
      GeneratedColumn<String>('gateway_config_json', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _updatedAtUtcMeta =
      const VerificationMeta('updatedAtUtc');
  @override
  late final GeneratedColumn<int> updatedAtUtc = GeneratedColumn<int>(
      'updated_at_utc', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        homeRegionId,
        primarySpeciesId,
        units,
        privacyOptInAggregate,
        cacheBudgetMb,
        useNmea2000WhenAvailable,
        gatewayConfigJson,
        updatedAtUtc
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_preferences';
  @override
  VerificationContext validateIntegrity(Insertable<UserPreferencesRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('home_region_id')) {
      context.handle(
          _homeRegionIdMeta,
          homeRegionId.isAcceptableOrUnknown(
              data['home_region_id']!, _homeRegionIdMeta));
    }
    if (data.containsKey('primary_species_id')) {
      context.handle(
          _primarySpeciesIdMeta,
          primarySpeciesId.isAcceptableOrUnknown(
              data['primary_species_id']!, _primarySpeciesIdMeta));
    }
    if (data.containsKey('units')) {
      context.handle(
          _unitsMeta, units.isAcceptableOrUnknown(data['units']!, _unitsMeta));
    }
    if (data.containsKey('privacy_opt_in_aggregate')) {
      context.handle(
          _privacyOptInAggregateMeta,
          privacyOptInAggregate.isAcceptableOrUnknown(
              data['privacy_opt_in_aggregate']!, _privacyOptInAggregateMeta));
    }
    if (data.containsKey('cache_budget_mb')) {
      context.handle(
          _cacheBudgetMbMeta,
          cacheBudgetMb.isAcceptableOrUnknown(
              data['cache_budget_mb']!, _cacheBudgetMbMeta));
    }
    if (data.containsKey('use_nmea2000_when_available')) {
      context.handle(
          _useNmea2000WhenAvailableMeta,
          useNmea2000WhenAvailable.isAcceptableOrUnknown(
              data['use_nmea2000_when_available']!,
              _useNmea2000WhenAvailableMeta));
    }
    if (data.containsKey('gateway_config_json')) {
      context.handle(
          _gatewayConfigJsonMeta,
          gatewayConfigJson.isAcceptableOrUnknown(
              data['gateway_config_json']!, _gatewayConfigJsonMeta));
    }
    if (data.containsKey('updated_at_utc')) {
      context.handle(
          _updatedAtUtcMeta,
          updatedAtUtc.isAcceptableOrUnknown(
              data['updated_at_utc']!, _updatedAtUtcMeta));
    } else if (isInserting) {
      context.missing(_updatedAtUtcMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserPreferencesRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserPreferencesRow(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      homeRegionId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}home_region_id']),
      primarySpeciesId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}primary_species_id']),
      units: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}units'])!,
      privacyOptInAggregate: attachedDatabase.typeMapping.read(
          DriftSqlType.bool,
          data['${effectivePrefix}privacy_opt_in_aggregate'])!,
      cacheBudgetMb: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}cache_budget_mb'])!,
      useNmea2000WhenAvailable: attachedDatabase.typeMapping.read(
          DriftSqlType.bool,
          data['${effectivePrefix}use_nmea2000_when_available'])!,
      gatewayConfigJson: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}gateway_config_json']),
      updatedAtUtc: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}updated_at_utc'])!,
    );
  }

  @override
  $UserPreferencesTableTable createAlias(String alias) {
    return $UserPreferencesTableTable(attachedDatabase, alias);
  }
}

class UserPreferencesRow extends DataClass
    implements Insertable<UserPreferencesRow> {
  final int id;
  final String? homeRegionId;
  final String? primarySpeciesId;
  final String units;
  final bool privacyOptInAggregate;
  final int cacheBudgetMb;
  final bool useNmea2000WhenAvailable;
  final String? gatewayConfigJson;
  final int updatedAtUtc;
  const UserPreferencesRow(
      {required this.id,
      this.homeRegionId,
      this.primarySpeciesId,
      required this.units,
      required this.privacyOptInAggregate,
      required this.cacheBudgetMb,
      required this.useNmea2000WhenAvailable,
      this.gatewayConfigJson,
      required this.updatedAtUtc});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || homeRegionId != null) {
      map['home_region_id'] = Variable<String>(homeRegionId);
    }
    if (!nullToAbsent || primarySpeciesId != null) {
      map['primary_species_id'] = Variable<String>(primarySpeciesId);
    }
    map['units'] = Variable<String>(units);
    map['privacy_opt_in_aggregate'] = Variable<bool>(privacyOptInAggregate);
    map['cache_budget_mb'] = Variable<int>(cacheBudgetMb);
    map['use_nmea2000_when_available'] =
        Variable<bool>(useNmea2000WhenAvailable);
    if (!nullToAbsent || gatewayConfigJson != null) {
      map['gateway_config_json'] = Variable<String>(gatewayConfigJson);
    }
    map['updated_at_utc'] = Variable<int>(updatedAtUtc);
    return map;
  }

  UserPreferencesTableCompanion toCompanion(bool nullToAbsent) {
    return UserPreferencesTableCompanion(
      id: Value(id),
      homeRegionId: homeRegionId == null && nullToAbsent
          ? const Value.absent()
          : Value(homeRegionId),
      primarySpeciesId: primarySpeciesId == null && nullToAbsent
          ? const Value.absent()
          : Value(primarySpeciesId),
      units: Value(units),
      privacyOptInAggregate: Value(privacyOptInAggregate),
      cacheBudgetMb: Value(cacheBudgetMb),
      useNmea2000WhenAvailable: Value(useNmea2000WhenAvailable),
      gatewayConfigJson: gatewayConfigJson == null && nullToAbsent
          ? const Value.absent()
          : Value(gatewayConfigJson),
      updatedAtUtc: Value(updatedAtUtc),
    );
  }

  factory UserPreferencesRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserPreferencesRow(
      id: serializer.fromJson<int>(json['id']),
      homeRegionId: serializer.fromJson<String?>(json['homeRegionId']),
      primarySpeciesId: serializer.fromJson<String?>(json['primarySpeciesId']),
      units: serializer.fromJson<String>(json['units']),
      privacyOptInAggregate:
          serializer.fromJson<bool>(json['privacyOptInAggregate']),
      cacheBudgetMb: serializer.fromJson<int>(json['cacheBudgetMb']),
      useNmea2000WhenAvailable:
          serializer.fromJson<bool>(json['useNmea2000WhenAvailable']),
      gatewayConfigJson:
          serializer.fromJson<String?>(json['gatewayConfigJson']),
      updatedAtUtc: serializer.fromJson<int>(json['updatedAtUtc']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'homeRegionId': serializer.toJson<String?>(homeRegionId),
      'primarySpeciesId': serializer.toJson<String?>(primarySpeciesId),
      'units': serializer.toJson<String>(units),
      'privacyOptInAggregate': serializer.toJson<bool>(privacyOptInAggregate),
      'cacheBudgetMb': serializer.toJson<int>(cacheBudgetMb),
      'useNmea2000WhenAvailable':
          serializer.toJson<bool>(useNmea2000WhenAvailable),
      'gatewayConfigJson': serializer.toJson<String?>(gatewayConfigJson),
      'updatedAtUtc': serializer.toJson<int>(updatedAtUtc),
    };
  }

  UserPreferencesRow copyWith(
          {int? id,
          Value<String?> homeRegionId = const Value.absent(),
          Value<String?> primarySpeciesId = const Value.absent(),
          String? units,
          bool? privacyOptInAggregate,
          int? cacheBudgetMb,
          bool? useNmea2000WhenAvailable,
          Value<String?> gatewayConfigJson = const Value.absent(),
          int? updatedAtUtc}) =>
      UserPreferencesRow(
        id: id ?? this.id,
        homeRegionId:
            homeRegionId.present ? homeRegionId.value : this.homeRegionId,
        primarySpeciesId: primarySpeciesId.present
            ? primarySpeciesId.value
            : this.primarySpeciesId,
        units: units ?? this.units,
        privacyOptInAggregate:
            privacyOptInAggregate ?? this.privacyOptInAggregate,
        cacheBudgetMb: cacheBudgetMb ?? this.cacheBudgetMb,
        useNmea2000WhenAvailable:
            useNmea2000WhenAvailable ?? this.useNmea2000WhenAvailable,
        gatewayConfigJson: gatewayConfigJson.present
            ? gatewayConfigJson.value
            : this.gatewayConfigJson,
        updatedAtUtc: updatedAtUtc ?? this.updatedAtUtc,
      );
  UserPreferencesRow copyWithCompanion(UserPreferencesTableCompanion data) {
    return UserPreferencesRow(
      id: data.id.present ? data.id.value : this.id,
      homeRegionId: data.homeRegionId.present
          ? data.homeRegionId.value
          : this.homeRegionId,
      primarySpeciesId: data.primarySpeciesId.present
          ? data.primarySpeciesId.value
          : this.primarySpeciesId,
      units: data.units.present ? data.units.value : this.units,
      privacyOptInAggregate: data.privacyOptInAggregate.present
          ? data.privacyOptInAggregate.value
          : this.privacyOptInAggregate,
      cacheBudgetMb: data.cacheBudgetMb.present
          ? data.cacheBudgetMb.value
          : this.cacheBudgetMb,
      useNmea2000WhenAvailable: data.useNmea2000WhenAvailable.present
          ? data.useNmea2000WhenAvailable.value
          : this.useNmea2000WhenAvailable,
      gatewayConfigJson: data.gatewayConfigJson.present
          ? data.gatewayConfigJson.value
          : this.gatewayConfigJson,
      updatedAtUtc: data.updatedAtUtc.present
          ? data.updatedAtUtc.value
          : this.updatedAtUtc,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserPreferencesRow(')
          ..write('id: $id, ')
          ..write('homeRegionId: $homeRegionId, ')
          ..write('primarySpeciesId: $primarySpeciesId, ')
          ..write('units: $units, ')
          ..write('privacyOptInAggregate: $privacyOptInAggregate, ')
          ..write('cacheBudgetMb: $cacheBudgetMb, ')
          ..write('useNmea2000WhenAvailable: $useNmea2000WhenAvailable, ')
          ..write('gatewayConfigJson: $gatewayConfigJson, ')
          ..write('updatedAtUtc: $updatedAtUtc')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      homeRegionId,
      primarySpeciesId,
      units,
      privacyOptInAggregate,
      cacheBudgetMb,
      useNmea2000WhenAvailable,
      gatewayConfigJson,
      updatedAtUtc);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserPreferencesRow &&
          other.id == this.id &&
          other.homeRegionId == this.homeRegionId &&
          other.primarySpeciesId == this.primarySpeciesId &&
          other.units == this.units &&
          other.privacyOptInAggregate == this.privacyOptInAggregate &&
          other.cacheBudgetMb == this.cacheBudgetMb &&
          other.useNmea2000WhenAvailable == this.useNmea2000WhenAvailable &&
          other.gatewayConfigJson == this.gatewayConfigJson &&
          other.updatedAtUtc == this.updatedAtUtc);
}

class UserPreferencesTableCompanion
    extends UpdateCompanion<UserPreferencesRow> {
  final Value<int> id;
  final Value<String?> homeRegionId;
  final Value<String?> primarySpeciesId;
  final Value<String> units;
  final Value<bool> privacyOptInAggregate;
  final Value<int> cacheBudgetMb;
  final Value<bool> useNmea2000WhenAvailable;
  final Value<String?> gatewayConfigJson;
  final Value<int> updatedAtUtc;
  const UserPreferencesTableCompanion({
    this.id = const Value.absent(),
    this.homeRegionId = const Value.absent(),
    this.primarySpeciesId = const Value.absent(),
    this.units = const Value.absent(),
    this.privacyOptInAggregate = const Value.absent(),
    this.cacheBudgetMb = const Value.absent(),
    this.useNmea2000WhenAvailable = const Value.absent(),
    this.gatewayConfigJson = const Value.absent(),
    this.updatedAtUtc = const Value.absent(),
  });
  UserPreferencesTableCompanion.insert({
    this.id = const Value.absent(),
    this.homeRegionId = const Value.absent(),
    this.primarySpeciesId = const Value.absent(),
    this.units = const Value.absent(),
    this.privacyOptInAggregate = const Value.absent(),
    this.cacheBudgetMb = const Value.absent(),
    this.useNmea2000WhenAvailable = const Value.absent(),
    this.gatewayConfigJson = const Value.absent(),
    required int updatedAtUtc,
  }) : updatedAtUtc = Value(updatedAtUtc);
  static Insertable<UserPreferencesRow> custom({
    Expression<int>? id,
    Expression<String>? homeRegionId,
    Expression<String>? primarySpeciesId,
    Expression<String>? units,
    Expression<bool>? privacyOptInAggregate,
    Expression<int>? cacheBudgetMb,
    Expression<bool>? useNmea2000WhenAvailable,
    Expression<String>? gatewayConfigJson,
    Expression<int>? updatedAtUtc,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (homeRegionId != null) 'home_region_id': homeRegionId,
      if (primarySpeciesId != null) 'primary_species_id': primarySpeciesId,
      if (units != null) 'units': units,
      if (privacyOptInAggregate != null)
        'privacy_opt_in_aggregate': privacyOptInAggregate,
      if (cacheBudgetMb != null) 'cache_budget_mb': cacheBudgetMb,
      if (useNmea2000WhenAvailable != null)
        'use_nmea2000_when_available': useNmea2000WhenAvailable,
      if (gatewayConfigJson != null) 'gateway_config_json': gatewayConfigJson,
      if (updatedAtUtc != null) 'updated_at_utc': updatedAtUtc,
    });
  }

  UserPreferencesTableCompanion copyWith(
      {Value<int>? id,
      Value<String?>? homeRegionId,
      Value<String?>? primarySpeciesId,
      Value<String>? units,
      Value<bool>? privacyOptInAggregate,
      Value<int>? cacheBudgetMb,
      Value<bool>? useNmea2000WhenAvailable,
      Value<String?>? gatewayConfigJson,
      Value<int>? updatedAtUtc}) {
    return UserPreferencesTableCompanion(
      id: id ?? this.id,
      homeRegionId: homeRegionId ?? this.homeRegionId,
      primarySpeciesId: primarySpeciesId ?? this.primarySpeciesId,
      units: units ?? this.units,
      privacyOptInAggregate:
          privacyOptInAggregate ?? this.privacyOptInAggregate,
      cacheBudgetMb: cacheBudgetMb ?? this.cacheBudgetMb,
      useNmea2000WhenAvailable:
          useNmea2000WhenAvailable ?? this.useNmea2000WhenAvailable,
      gatewayConfigJson: gatewayConfigJson ?? this.gatewayConfigJson,
      updatedAtUtc: updatedAtUtc ?? this.updatedAtUtc,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (homeRegionId.present) {
      map['home_region_id'] = Variable<String>(homeRegionId.value);
    }
    if (primarySpeciesId.present) {
      map['primary_species_id'] = Variable<String>(primarySpeciesId.value);
    }
    if (units.present) {
      map['units'] = Variable<String>(units.value);
    }
    if (privacyOptInAggregate.present) {
      map['privacy_opt_in_aggregate'] =
          Variable<bool>(privacyOptInAggregate.value);
    }
    if (cacheBudgetMb.present) {
      map['cache_budget_mb'] = Variable<int>(cacheBudgetMb.value);
    }
    if (useNmea2000WhenAvailable.present) {
      map['use_nmea2000_when_available'] =
          Variable<bool>(useNmea2000WhenAvailable.value);
    }
    if (gatewayConfigJson.present) {
      map['gateway_config_json'] = Variable<String>(gatewayConfigJson.value);
    }
    if (updatedAtUtc.present) {
      map['updated_at_utc'] = Variable<int>(updatedAtUtc.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserPreferencesTableCompanion(')
          ..write('id: $id, ')
          ..write('homeRegionId: $homeRegionId, ')
          ..write('primarySpeciesId: $primarySpeciesId, ')
          ..write('units: $units, ')
          ..write('privacyOptInAggregate: $privacyOptInAggregate, ')
          ..write('cacheBudgetMb: $cacheBudgetMb, ')
          ..write('useNmea2000WhenAvailable: $useNmea2000WhenAvailable, ')
          ..write('gatewayConfigJson: $gatewayConfigJson, ')
          ..write('updatedAtUtc: $updatedAtUtc')
          ..write(')'))
        .toString();
  }
}

class $SyncQueueTable extends SyncQueue
    with TableInfo<$SyncQueueTable, SyncQueueEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncQueueTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _targetTableMeta =
      const VerificationMeta('targetTable');
  @override
  late final GeneratedColumn<String> targetTable = GeneratedColumn<String>(
      'table_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _recordIdMeta =
      const VerificationMeta('recordId');
  @override
  late final GeneratedColumn<String> recordId = GeneratedColumn<String>(
      'record_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _operationMeta =
      const VerificationMeta('operation');
  @override
  late final GeneratedColumn<String> operation = GeneratedColumn<String>(
      'operation', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _payloadJsonMeta =
      const VerificationMeta('payloadJson');
  @override
  late final GeneratedColumn<String> payloadJson = GeneratedColumn<String>(
      'payload_json', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _enqueuedAtUtcMeta =
      const VerificationMeta('enqueuedAtUtc');
  @override
  late final GeneratedColumn<int> enqueuedAtUtc = GeneratedColumn<int>(
      'enqueued_at_utc', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _attemptCountMeta =
      const VerificationMeta('attemptCount');
  @override
  late final GeneratedColumn<int> attemptCount = GeneratedColumn<int>(
      'attempt_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _lastErrorMeta =
      const VerificationMeta('lastError');
  @override
  late final GeneratedColumn<String> lastError = GeneratedColumn<String>(
      'last_error', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        targetTable,
        recordId,
        operation,
        payloadJson,
        enqueuedAtUtc,
        attemptCount,
        lastError
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_queue';
  @override
  VerificationContext validateIntegrity(Insertable<SyncQueueEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('table_name')) {
      context.handle(
          _targetTableMeta,
          targetTable.isAcceptableOrUnknown(
              data['table_name']!, _targetTableMeta));
    } else if (isInserting) {
      context.missing(_targetTableMeta);
    }
    if (data.containsKey('record_id')) {
      context.handle(_recordIdMeta,
          recordId.isAcceptableOrUnknown(data['record_id']!, _recordIdMeta));
    } else if (isInserting) {
      context.missing(_recordIdMeta);
    }
    if (data.containsKey('operation')) {
      context.handle(_operationMeta,
          operation.isAcceptableOrUnknown(data['operation']!, _operationMeta));
    } else if (isInserting) {
      context.missing(_operationMeta);
    }
    if (data.containsKey('payload_json')) {
      context.handle(
          _payloadJsonMeta,
          payloadJson.isAcceptableOrUnknown(
              data['payload_json']!, _payloadJsonMeta));
    } else if (isInserting) {
      context.missing(_payloadJsonMeta);
    }
    if (data.containsKey('enqueued_at_utc')) {
      context.handle(
          _enqueuedAtUtcMeta,
          enqueuedAtUtc.isAcceptableOrUnknown(
              data['enqueued_at_utc']!, _enqueuedAtUtcMeta));
    } else if (isInserting) {
      context.missing(_enqueuedAtUtcMeta);
    }
    if (data.containsKey('attempt_count')) {
      context.handle(
          _attemptCountMeta,
          attemptCount.isAcceptableOrUnknown(
              data['attempt_count']!, _attemptCountMeta));
    }
    if (data.containsKey('last_error')) {
      context.handle(_lastErrorMeta,
          lastError.isAcceptableOrUnknown(data['last_error']!, _lastErrorMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SyncQueueEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncQueueEntry(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      targetTable: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}table_name'])!,
      recordId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}record_id'])!,
      operation: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}operation'])!,
      payloadJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}payload_json'])!,
      enqueuedAtUtc: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}enqueued_at_utc'])!,
      attemptCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}attempt_count'])!,
      lastError: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}last_error']),
    );
  }

  @override
  $SyncQueueTable createAlias(String alias) {
    return $SyncQueueTable(attachedDatabase, alias);
  }
}

class SyncQueueEntry extends DataClass implements Insertable<SyncQueueEntry> {
  final int id;
  final String targetTable;
  final String recordId;
  final String operation;
  final String payloadJson;
  final int enqueuedAtUtc;
  final int attemptCount;
  final String? lastError;
  const SyncQueueEntry(
      {required this.id,
      required this.targetTable,
      required this.recordId,
      required this.operation,
      required this.payloadJson,
      required this.enqueuedAtUtc,
      required this.attemptCount,
      this.lastError});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['table_name'] = Variable<String>(targetTable);
    map['record_id'] = Variable<String>(recordId);
    map['operation'] = Variable<String>(operation);
    map['payload_json'] = Variable<String>(payloadJson);
    map['enqueued_at_utc'] = Variable<int>(enqueuedAtUtc);
    map['attempt_count'] = Variable<int>(attemptCount);
    if (!nullToAbsent || lastError != null) {
      map['last_error'] = Variable<String>(lastError);
    }
    return map;
  }

  SyncQueueCompanion toCompanion(bool nullToAbsent) {
    return SyncQueueCompanion(
      id: Value(id),
      targetTable: Value(targetTable),
      recordId: Value(recordId),
      operation: Value(operation),
      payloadJson: Value(payloadJson),
      enqueuedAtUtc: Value(enqueuedAtUtc),
      attemptCount: Value(attemptCount),
      lastError: lastError == null && nullToAbsent
          ? const Value.absent()
          : Value(lastError),
    );
  }

  factory SyncQueueEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncQueueEntry(
      id: serializer.fromJson<int>(json['id']),
      targetTable: serializer.fromJson<String>(json['targetTable']),
      recordId: serializer.fromJson<String>(json['recordId']),
      operation: serializer.fromJson<String>(json['operation']),
      payloadJson: serializer.fromJson<String>(json['payloadJson']),
      enqueuedAtUtc: serializer.fromJson<int>(json['enqueuedAtUtc']),
      attemptCount: serializer.fromJson<int>(json['attemptCount']),
      lastError: serializer.fromJson<String?>(json['lastError']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'targetTable': serializer.toJson<String>(targetTable),
      'recordId': serializer.toJson<String>(recordId),
      'operation': serializer.toJson<String>(operation),
      'payloadJson': serializer.toJson<String>(payloadJson),
      'enqueuedAtUtc': serializer.toJson<int>(enqueuedAtUtc),
      'attemptCount': serializer.toJson<int>(attemptCount),
      'lastError': serializer.toJson<String?>(lastError),
    };
  }

  SyncQueueEntry copyWith(
          {int? id,
          String? targetTable,
          String? recordId,
          String? operation,
          String? payloadJson,
          int? enqueuedAtUtc,
          int? attemptCount,
          Value<String?> lastError = const Value.absent()}) =>
      SyncQueueEntry(
        id: id ?? this.id,
        targetTable: targetTable ?? this.targetTable,
        recordId: recordId ?? this.recordId,
        operation: operation ?? this.operation,
        payloadJson: payloadJson ?? this.payloadJson,
        enqueuedAtUtc: enqueuedAtUtc ?? this.enqueuedAtUtc,
        attemptCount: attemptCount ?? this.attemptCount,
        lastError: lastError.present ? lastError.value : this.lastError,
      );
  SyncQueueEntry copyWithCompanion(SyncQueueCompanion data) {
    return SyncQueueEntry(
      id: data.id.present ? data.id.value : this.id,
      targetTable:
          data.targetTable.present ? data.targetTable.value : this.targetTable,
      recordId: data.recordId.present ? data.recordId.value : this.recordId,
      operation: data.operation.present ? data.operation.value : this.operation,
      payloadJson:
          data.payloadJson.present ? data.payloadJson.value : this.payloadJson,
      enqueuedAtUtc: data.enqueuedAtUtc.present
          ? data.enqueuedAtUtc.value
          : this.enqueuedAtUtc,
      attemptCount: data.attemptCount.present
          ? data.attemptCount.value
          : this.attemptCount,
      lastError: data.lastError.present ? data.lastError.value : this.lastError,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueEntry(')
          ..write('id: $id, ')
          ..write('targetTable: $targetTable, ')
          ..write('recordId: $recordId, ')
          ..write('operation: $operation, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('enqueuedAtUtc: $enqueuedAtUtc, ')
          ..write('attemptCount: $attemptCount, ')
          ..write('lastError: $lastError')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, targetTable, recordId, operation,
      payloadJson, enqueuedAtUtc, attemptCount, lastError);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncQueueEntry &&
          other.id == this.id &&
          other.targetTable == this.targetTable &&
          other.recordId == this.recordId &&
          other.operation == this.operation &&
          other.payloadJson == this.payloadJson &&
          other.enqueuedAtUtc == this.enqueuedAtUtc &&
          other.attemptCount == this.attemptCount &&
          other.lastError == this.lastError);
}

class SyncQueueCompanion extends UpdateCompanion<SyncQueueEntry> {
  final Value<int> id;
  final Value<String> targetTable;
  final Value<String> recordId;
  final Value<String> operation;
  final Value<String> payloadJson;
  final Value<int> enqueuedAtUtc;
  final Value<int> attemptCount;
  final Value<String?> lastError;
  const SyncQueueCompanion({
    this.id = const Value.absent(),
    this.targetTable = const Value.absent(),
    this.recordId = const Value.absent(),
    this.operation = const Value.absent(),
    this.payloadJson = const Value.absent(),
    this.enqueuedAtUtc = const Value.absent(),
    this.attemptCount = const Value.absent(),
    this.lastError = const Value.absent(),
  });
  SyncQueueCompanion.insert({
    this.id = const Value.absent(),
    required String targetTable,
    required String recordId,
    required String operation,
    required String payloadJson,
    required int enqueuedAtUtc,
    this.attemptCount = const Value.absent(),
    this.lastError = const Value.absent(),
  })  : targetTable = Value(targetTable),
        recordId = Value(recordId),
        operation = Value(operation),
        payloadJson = Value(payloadJson),
        enqueuedAtUtc = Value(enqueuedAtUtc);
  static Insertable<SyncQueueEntry> custom({
    Expression<int>? id,
    Expression<String>? targetTable,
    Expression<String>? recordId,
    Expression<String>? operation,
    Expression<String>? payloadJson,
    Expression<int>? enqueuedAtUtc,
    Expression<int>? attemptCount,
    Expression<String>? lastError,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (targetTable != null) 'table_name': targetTable,
      if (recordId != null) 'record_id': recordId,
      if (operation != null) 'operation': operation,
      if (payloadJson != null) 'payload_json': payloadJson,
      if (enqueuedAtUtc != null) 'enqueued_at_utc': enqueuedAtUtc,
      if (attemptCount != null) 'attempt_count': attemptCount,
      if (lastError != null) 'last_error': lastError,
    });
  }

  SyncQueueCompanion copyWith(
      {Value<int>? id,
      Value<String>? targetTable,
      Value<String>? recordId,
      Value<String>? operation,
      Value<String>? payloadJson,
      Value<int>? enqueuedAtUtc,
      Value<int>? attemptCount,
      Value<String?>? lastError}) {
    return SyncQueueCompanion(
      id: id ?? this.id,
      targetTable: targetTable ?? this.targetTable,
      recordId: recordId ?? this.recordId,
      operation: operation ?? this.operation,
      payloadJson: payloadJson ?? this.payloadJson,
      enqueuedAtUtc: enqueuedAtUtc ?? this.enqueuedAtUtc,
      attemptCount: attemptCount ?? this.attemptCount,
      lastError: lastError ?? this.lastError,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (targetTable.present) {
      map['table_name'] = Variable<String>(targetTable.value);
    }
    if (recordId.present) {
      map['record_id'] = Variable<String>(recordId.value);
    }
    if (operation.present) {
      map['operation'] = Variable<String>(operation.value);
    }
    if (payloadJson.present) {
      map['payload_json'] = Variable<String>(payloadJson.value);
    }
    if (enqueuedAtUtc.present) {
      map['enqueued_at_utc'] = Variable<int>(enqueuedAtUtc.value);
    }
    if (attemptCount.present) {
      map['attempt_count'] = Variable<int>(attemptCount.value);
    }
    if (lastError.present) {
      map['last_error'] = Variable<String>(lastError.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueCompanion(')
          ..write('id: $id, ')
          ..write('targetTable: $targetTable, ')
          ..write('recordId: $recordId, ')
          ..write('operation: $operation, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('enqueuedAtUtc: $enqueuedAtUtc, ')
          ..write('attemptCount: $attemptCount, ')
          ..write('lastError: $lastError')
          ..write(')'))
        .toString();
  }
}

class $ConditionsCacheTable extends ConditionsCache
    with TableInfo<$ConditionsCacheTable, ConditionsCacheRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ConditionsCacheTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _cacheKeyMeta =
      const VerificationMeta('cacheKey');
  @override
  late final GeneratedColumn<String> cacheKey = GeneratedColumn<String>(
      'cache_key', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dataTypeMeta =
      const VerificationMeta('dataType');
  @override
  late final GeneratedColumn<String> dataType = GeneratedColumn<String>(
      'data_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
      'source', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _valueJsonMeta =
      const VerificationMeta('valueJson');
  @override
  late final GeneratedColumn<String> valueJson = GeneratedColumn<String>(
      'value_json', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _fetchedAtUtcMeta =
      const VerificationMeta('fetchedAtUtc');
  @override
  late final GeneratedColumn<int> fetchedAtUtc = GeneratedColumn<int>(
      'fetched_at_utc', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _validUntilUtcMeta =
      const VerificationMeta('validUntilUtc');
  @override
  late final GeneratedColumn<int> validUntilUtc = GeneratedColumn<int>(
      'valid_until_utc', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _sizeBytesMeta =
      const VerificationMeta('sizeBytes');
  @override
  late final GeneratedColumn<int> sizeBytes = GeneratedColumn<int>(
      'size_bytes', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _lastAccessedUtcMeta =
      const VerificationMeta('lastAccessedUtc');
  @override
  late final GeneratedColumn<int> lastAccessedUtc = GeneratedColumn<int>(
      'last_accessed_utc', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        cacheKey,
        dataType,
        source,
        valueJson,
        fetchedAtUtc,
        validUntilUtc,
        sizeBytes,
        lastAccessedUtc
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'conditions_cache';
  @override
  VerificationContext validateIntegrity(Insertable<ConditionsCacheRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('cache_key')) {
      context.handle(_cacheKeyMeta,
          cacheKey.isAcceptableOrUnknown(data['cache_key']!, _cacheKeyMeta));
    } else if (isInserting) {
      context.missing(_cacheKeyMeta);
    }
    if (data.containsKey('data_type')) {
      context.handle(_dataTypeMeta,
          dataType.isAcceptableOrUnknown(data['data_type']!, _dataTypeMeta));
    } else if (isInserting) {
      context.missing(_dataTypeMeta);
    }
    if (data.containsKey('source')) {
      context.handle(_sourceMeta,
          source.isAcceptableOrUnknown(data['source']!, _sourceMeta));
    } else if (isInserting) {
      context.missing(_sourceMeta);
    }
    if (data.containsKey('value_json')) {
      context.handle(_valueJsonMeta,
          valueJson.isAcceptableOrUnknown(data['value_json']!, _valueJsonMeta));
    } else if (isInserting) {
      context.missing(_valueJsonMeta);
    }
    if (data.containsKey('fetched_at_utc')) {
      context.handle(
          _fetchedAtUtcMeta,
          fetchedAtUtc.isAcceptableOrUnknown(
              data['fetched_at_utc']!, _fetchedAtUtcMeta));
    } else if (isInserting) {
      context.missing(_fetchedAtUtcMeta);
    }
    if (data.containsKey('valid_until_utc')) {
      context.handle(
          _validUntilUtcMeta,
          validUntilUtc.isAcceptableOrUnknown(
              data['valid_until_utc']!, _validUntilUtcMeta));
    } else if (isInserting) {
      context.missing(_validUntilUtcMeta);
    }
    if (data.containsKey('size_bytes')) {
      context.handle(_sizeBytesMeta,
          sizeBytes.isAcceptableOrUnknown(data['size_bytes']!, _sizeBytesMeta));
    } else if (isInserting) {
      context.missing(_sizeBytesMeta);
    }
    if (data.containsKey('last_accessed_utc')) {
      context.handle(
          _lastAccessedUtcMeta,
          lastAccessedUtc.isAcceptableOrUnknown(
              data['last_accessed_utc']!, _lastAccessedUtcMeta));
    } else if (isInserting) {
      context.missing(_lastAccessedUtcMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {cacheKey};
  @override
  ConditionsCacheRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ConditionsCacheRow(
      cacheKey: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cache_key'])!,
      dataType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}data_type'])!,
      source: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}source'])!,
      valueJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}value_json'])!,
      fetchedAtUtc: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}fetched_at_utc'])!,
      validUntilUtc: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}valid_until_utc'])!,
      sizeBytes: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}size_bytes'])!,
      lastAccessedUtc: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}last_accessed_utc'])!,
    );
  }

  @override
  $ConditionsCacheTable createAlias(String alias) {
    return $ConditionsCacheTable(attachedDatabase, alias);
  }
}

class ConditionsCacheRow extends DataClass
    implements Insertable<ConditionsCacheRow> {
  final String cacheKey;
  final String dataType;
  final String source;
  final String valueJson;
  final int fetchedAtUtc;
  final int validUntilUtc;
  final int sizeBytes;
  final int lastAccessedUtc;
  const ConditionsCacheRow(
      {required this.cacheKey,
      required this.dataType,
      required this.source,
      required this.valueJson,
      required this.fetchedAtUtc,
      required this.validUntilUtc,
      required this.sizeBytes,
      required this.lastAccessedUtc});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['cache_key'] = Variable<String>(cacheKey);
    map['data_type'] = Variable<String>(dataType);
    map['source'] = Variable<String>(source);
    map['value_json'] = Variable<String>(valueJson);
    map['fetched_at_utc'] = Variable<int>(fetchedAtUtc);
    map['valid_until_utc'] = Variable<int>(validUntilUtc);
    map['size_bytes'] = Variable<int>(sizeBytes);
    map['last_accessed_utc'] = Variable<int>(lastAccessedUtc);
    return map;
  }

  ConditionsCacheCompanion toCompanion(bool nullToAbsent) {
    return ConditionsCacheCompanion(
      cacheKey: Value(cacheKey),
      dataType: Value(dataType),
      source: Value(source),
      valueJson: Value(valueJson),
      fetchedAtUtc: Value(fetchedAtUtc),
      validUntilUtc: Value(validUntilUtc),
      sizeBytes: Value(sizeBytes),
      lastAccessedUtc: Value(lastAccessedUtc),
    );
  }

  factory ConditionsCacheRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ConditionsCacheRow(
      cacheKey: serializer.fromJson<String>(json['cacheKey']),
      dataType: serializer.fromJson<String>(json['dataType']),
      source: serializer.fromJson<String>(json['source']),
      valueJson: serializer.fromJson<String>(json['valueJson']),
      fetchedAtUtc: serializer.fromJson<int>(json['fetchedAtUtc']),
      validUntilUtc: serializer.fromJson<int>(json['validUntilUtc']),
      sizeBytes: serializer.fromJson<int>(json['sizeBytes']),
      lastAccessedUtc: serializer.fromJson<int>(json['lastAccessedUtc']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'cacheKey': serializer.toJson<String>(cacheKey),
      'dataType': serializer.toJson<String>(dataType),
      'source': serializer.toJson<String>(source),
      'valueJson': serializer.toJson<String>(valueJson),
      'fetchedAtUtc': serializer.toJson<int>(fetchedAtUtc),
      'validUntilUtc': serializer.toJson<int>(validUntilUtc),
      'sizeBytes': serializer.toJson<int>(sizeBytes),
      'lastAccessedUtc': serializer.toJson<int>(lastAccessedUtc),
    };
  }

  ConditionsCacheRow copyWith(
          {String? cacheKey,
          String? dataType,
          String? source,
          String? valueJson,
          int? fetchedAtUtc,
          int? validUntilUtc,
          int? sizeBytes,
          int? lastAccessedUtc}) =>
      ConditionsCacheRow(
        cacheKey: cacheKey ?? this.cacheKey,
        dataType: dataType ?? this.dataType,
        source: source ?? this.source,
        valueJson: valueJson ?? this.valueJson,
        fetchedAtUtc: fetchedAtUtc ?? this.fetchedAtUtc,
        validUntilUtc: validUntilUtc ?? this.validUntilUtc,
        sizeBytes: sizeBytes ?? this.sizeBytes,
        lastAccessedUtc: lastAccessedUtc ?? this.lastAccessedUtc,
      );
  ConditionsCacheRow copyWithCompanion(ConditionsCacheCompanion data) {
    return ConditionsCacheRow(
      cacheKey: data.cacheKey.present ? data.cacheKey.value : this.cacheKey,
      dataType: data.dataType.present ? data.dataType.value : this.dataType,
      source: data.source.present ? data.source.value : this.source,
      valueJson: data.valueJson.present ? data.valueJson.value : this.valueJson,
      fetchedAtUtc: data.fetchedAtUtc.present
          ? data.fetchedAtUtc.value
          : this.fetchedAtUtc,
      validUntilUtc: data.validUntilUtc.present
          ? data.validUntilUtc.value
          : this.validUntilUtc,
      sizeBytes: data.sizeBytes.present ? data.sizeBytes.value : this.sizeBytes,
      lastAccessedUtc: data.lastAccessedUtc.present
          ? data.lastAccessedUtc.value
          : this.lastAccessedUtc,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ConditionsCacheRow(')
          ..write('cacheKey: $cacheKey, ')
          ..write('dataType: $dataType, ')
          ..write('source: $source, ')
          ..write('valueJson: $valueJson, ')
          ..write('fetchedAtUtc: $fetchedAtUtc, ')
          ..write('validUntilUtc: $validUntilUtc, ')
          ..write('sizeBytes: $sizeBytes, ')
          ..write('lastAccessedUtc: $lastAccessedUtc')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(cacheKey, dataType, source, valueJson,
      fetchedAtUtc, validUntilUtc, sizeBytes, lastAccessedUtc);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ConditionsCacheRow &&
          other.cacheKey == this.cacheKey &&
          other.dataType == this.dataType &&
          other.source == this.source &&
          other.valueJson == this.valueJson &&
          other.fetchedAtUtc == this.fetchedAtUtc &&
          other.validUntilUtc == this.validUntilUtc &&
          other.sizeBytes == this.sizeBytes &&
          other.lastAccessedUtc == this.lastAccessedUtc);
}

class ConditionsCacheCompanion extends UpdateCompanion<ConditionsCacheRow> {
  final Value<String> cacheKey;
  final Value<String> dataType;
  final Value<String> source;
  final Value<String> valueJson;
  final Value<int> fetchedAtUtc;
  final Value<int> validUntilUtc;
  final Value<int> sizeBytes;
  final Value<int> lastAccessedUtc;
  final Value<int> rowid;
  const ConditionsCacheCompanion({
    this.cacheKey = const Value.absent(),
    this.dataType = const Value.absent(),
    this.source = const Value.absent(),
    this.valueJson = const Value.absent(),
    this.fetchedAtUtc = const Value.absent(),
    this.validUntilUtc = const Value.absent(),
    this.sizeBytes = const Value.absent(),
    this.lastAccessedUtc = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ConditionsCacheCompanion.insert({
    required String cacheKey,
    required String dataType,
    required String source,
    required String valueJson,
    required int fetchedAtUtc,
    required int validUntilUtc,
    required int sizeBytes,
    required int lastAccessedUtc,
    this.rowid = const Value.absent(),
  })  : cacheKey = Value(cacheKey),
        dataType = Value(dataType),
        source = Value(source),
        valueJson = Value(valueJson),
        fetchedAtUtc = Value(fetchedAtUtc),
        validUntilUtc = Value(validUntilUtc),
        sizeBytes = Value(sizeBytes),
        lastAccessedUtc = Value(lastAccessedUtc);
  static Insertable<ConditionsCacheRow> custom({
    Expression<String>? cacheKey,
    Expression<String>? dataType,
    Expression<String>? source,
    Expression<String>? valueJson,
    Expression<int>? fetchedAtUtc,
    Expression<int>? validUntilUtc,
    Expression<int>? sizeBytes,
    Expression<int>? lastAccessedUtc,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (cacheKey != null) 'cache_key': cacheKey,
      if (dataType != null) 'data_type': dataType,
      if (source != null) 'source': source,
      if (valueJson != null) 'value_json': valueJson,
      if (fetchedAtUtc != null) 'fetched_at_utc': fetchedAtUtc,
      if (validUntilUtc != null) 'valid_until_utc': validUntilUtc,
      if (sizeBytes != null) 'size_bytes': sizeBytes,
      if (lastAccessedUtc != null) 'last_accessed_utc': lastAccessedUtc,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ConditionsCacheCompanion copyWith(
      {Value<String>? cacheKey,
      Value<String>? dataType,
      Value<String>? source,
      Value<String>? valueJson,
      Value<int>? fetchedAtUtc,
      Value<int>? validUntilUtc,
      Value<int>? sizeBytes,
      Value<int>? lastAccessedUtc,
      Value<int>? rowid}) {
    return ConditionsCacheCompanion(
      cacheKey: cacheKey ?? this.cacheKey,
      dataType: dataType ?? this.dataType,
      source: source ?? this.source,
      valueJson: valueJson ?? this.valueJson,
      fetchedAtUtc: fetchedAtUtc ?? this.fetchedAtUtc,
      validUntilUtc: validUntilUtc ?? this.validUntilUtc,
      sizeBytes: sizeBytes ?? this.sizeBytes,
      lastAccessedUtc: lastAccessedUtc ?? this.lastAccessedUtc,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (cacheKey.present) {
      map['cache_key'] = Variable<String>(cacheKey.value);
    }
    if (dataType.present) {
      map['data_type'] = Variable<String>(dataType.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (valueJson.present) {
      map['value_json'] = Variable<String>(valueJson.value);
    }
    if (fetchedAtUtc.present) {
      map['fetched_at_utc'] = Variable<int>(fetchedAtUtc.value);
    }
    if (validUntilUtc.present) {
      map['valid_until_utc'] = Variable<int>(validUntilUtc.value);
    }
    if (sizeBytes.present) {
      map['size_bytes'] = Variable<int>(sizeBytes.value);
    }
    if (lastAccessedUtc.present) {
      map['last_accessed_utc'] = Variable<int>(lastAccessedUtc.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ConditionsCacheCompanion(')
          ..write('cacheKey: $cacheKey, ')
          ..write('dataType: $dataType, ')
          ..write('source: $source, ')
          ..write('valueJson: $valueJson, ')
          ..write('fetchedAtUtc: $fetchedAtUtc, ')
          ..write('validUntilUtc: $validUntilUtc, ')
          ..write('sizeBytes: $sizeBytes, ')
          ..write('lastAccessedUtc: $lastAccessedUtc, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ScoreCacheTable extends ScoreCache
    with TableInfo<$ScoreCacheTable, ScoreCacheRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ScoreCacheTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _cacheKeyMeta =
      const VerificationMeta('cacheKey');
  @override
  late final GeneratedColumn<String> cacheKey = GeneratedColumn<String>(
      'cache_key', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _speciesIdMeta =
      const VerificationMeta('speciesId');
  @override
  late final GeneratedColumn<String> speciesId = GeneratedColumn<String>(
      'species_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _cellLatMeta =
      const VerificationMeta('cellLat');
  @override
  late final GeneratedColumn<double> cellLat = GeneratedColumn<double>(
      'cell_lat', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _cellLonMeta =
      const VerificationMeta('cellLon');
  @override
  late final GeneratedColumn<double> cellLon = GeneratedColumn<double>(
      'cell_lon', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _conditionsHashMeta =
      const VerificationMeta('conditionsHash');
  @override
  late final GeneratedColumn<String> conditionsHash = GeneratedColumn<String>(
      'conditions_hash', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _scoreMeta = const VerificationMeta('score');
  @override
  late final GeneratedColumn<double> score = GeneratedColumn<double>(
      'score', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _reasoningJsonMeta =
      const VerificationMeta('reasoningJson');
  @override
  late final GeneratedColumn<String> reasoningJson = GeneratedColumn<String>(
      'reasoning_json', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _computedAtUtcMeta =
      const VerificationMeta('computedAtUtc');
  @override
  late final GeneratedColumn<int> computedAtUtc = GeneratedColumn<int>(
      'computed_at_utc', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _validUntilUtcMeta =
      const VerificationMeta('validUntilUtc');
  @override
  late final GeneratedColumn<int> validUntilUtc = GeneratedColumn<int>(
      'valid_until_utc', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _lastAccessedUtcMeta =
      const VerificationMeta('lastAccessedUtc');
  @override
  late final GeneratedColumn<int> lastAccessedUtc = GeneratedColumn<int>(
      'last_accessed_utc', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        cacheKey,
        speciesId,
        cellLat,
        cellLon,
        conditionsHash,
        score,
        reasoningJson,
        computedAtUtc,
        validUntilUtc,
        lastAccessedUtc
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'score_cache';
  @override
  VerificationContext validateIntegrity(Insertable<ScoreCacheRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('cache_key')) {
      context.handle(_cacheKeyMeta,
          cacheKey.isAcceptableOrUnknown(data['cache_key']!, _cacheKeyMeta));
    } else if (isInserting) {
      context.missing(_cacheKeyMeta);
    }
    if (data.containsKey('species_id')) {
      context.handle(_speciesIdMeta,
          speciesId.isAcceptableOrUnknown(data['species_id']!, _speciesIdMeta));
    } else if (isInserting) {
      context.missing(_speciesIdMeta);
    }
    if (data.containsKey('cell_lat')) {
      context.handle(_cellLatMeta,
          cellLat.isAcceptableOrUnknown(data['cell_lat']!, _cellLatMeta));
    } else if (isInserting) {
      context.missing(_cellLatMeta);
    }
    if (data.containsKey('cell_lon')) {
      context.handle(_cellLonMeta,
          cellLon.isAcceptableOrUnknown(data['cell_lon']!, _cellLonMeta));
    } else if (isInserting) {
      context.missing(_cellLonMeta);
    }
    if (data.containsKey('conditions_hash')) {
      context.handle(
          _conditionsHashMeta,
          conditionsHash.isAcceptableOrUnknown(
              data['conditions_hash']!, _conditionsHashMeta));
    } else if (isInserting) {
      context.missing(_conditionsHashMeta);
    }
    if (data.containsKey('score')) {
      context.handle(
          _scoreMeta, score.isAcceptableOrUnknown(data['score']!, _scoreMeta));
    } else if (isInserting) {
      context.missing(_scoreMeta);
    }
    if (data.containsKey('reasoning_json')) {
      context.handle(
          _reasoningJsonMeta,
          reasoningJson.isAcceptableOrUnknown(
              data['reasoning_json']!, _reasoningJsonMeta));
    } else if (isInserting) {
      context.missing(_reasoningJsonMeta);
    }
    if (data.containsKey('computed_at_utc')) {
      context.handle(
          _computedAtUtcMeta,
          computedAtUtc.isAcceptableOrUnknown(
              data['computed_at_utc']!, _computedAtUtcMeta));
    } else if (isInserting) {
      context.missing(_computedAtUtcMeta);
    }
    if (data.containsKey('valid_until_utc')) {
      context.handle(
          _validUntilUtcMeta,
          validUntilUtc.isAcceptableOrUnknown(
              data['valid_until_utc']!, _validUntilUtcMeta));
    } else if (isInserting) {
      context.missing(_validUntilUtcMeta);
    }
    if (data.containsKey('last_accessed_utc')) {
      context.handle(
          _lastAccessedUtcMeta,
          lastAccessedUtc.isAcceptableOrUnknown(
              data['last_accessed_utc']!, _lastAccessedUtcMeta));
    } else if (isInserting) {
      context.missing(_lastAccessedUtcMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {cacheKey};
  @override
  ScoreCacheRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ScoreCacheRow(
      cacheKey: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cache_key'])!,
      speciesId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}species_id'])!,
      cellLat: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}cell_lat'])!,
      cellLon: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}cell_lon'])!,
      conditionsHash: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}conditions_hash'])!,
      score: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}score'])!,
      reasoningJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}reasoning_json'])!,
      computedAtUtc: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}computed_at_utc'])!,
      validUntilUtc: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}valid_until_utc'])!,
      lastAccessedUtc: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}last_accessed_utc'])!,
    );
  }

  @override
  $ScoreCacheTable createAlias(String alias) {
    return $ScoreCacheTable(attachedDatabase, alias);
  }
}

class ScoreCacheRow extends DataClass implements Insertable<ScoreCacheRow> {
  final String cacheKey;
  final String speciesId;
  final double cellLat;
  final double cellLon;
  final String conditionsHash;
  final double score;
  final String reasoningJson;
  final int computedAtUtc;
  final int validUntilUtc;
  final int lastAccessedUtc;
  const ScoreCacheRow(
      {required this.cacheKey,
      required this.speciesId,
      required this.cellLat,
      required this.cellLon,
      required this.conditionsHash,
      required this.score,
      required this.reasoningJson,
      required this.computedAtUtc,
      required this.validUntilUtc,
      required this.lastAccessedUtc});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['cache_key'] = Variable<String>(cacheKey);
    map['species_id'] = Variable<String>(speciesId);
    map['cell_lat'] = Variable<double>(cellLat);
    map['cell_lon'] = Variable<double>(cellLon);
    map['conditions_hash'] = Variable<String>(conditionsHash);
    map['score'] = Variable<double>(score);
    map['reasoning_json'] = Variable<String>(reasoningJson);
    map['computed_at_utc'] = Variable<int>(computedAtUtc);
    map['valid_until_utc'] = Variable<int>(validUntilUtc);
    map['last_accessed_utc'] = Variable<int>(lastAccessedUtc);
    return map;
  }

  ScoreCacheCompanion toCompanion(bool nullToAbsent) {
    return ScoreCacheCompanion(
      cacheKey: Value(cacheKey),
      speciesId: Value(speciesId),
      cellLat: Value(cellLat),
      cellLon: Value(cellLon),
      conditionsHash: Value(conditionsHash),
      score: Value(score),
      reasoningJson: Value(reasoningJson),
      computedAtUtc: Value(computedAtUtc),
      validUntilUtc: Value(validUntilUtc),
      lastAccessedUtc: Value(lastAccessedUtc),
    );
  }

  factory ScoreCacheRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ScoreCacheRow(
      cacheKey: serializer.fromJson<String>(json['cacheKey']),
      speciesId: serializer.fromJson<String>(json['speciesId']),
      cellLat: serializer.fromJson<double>(json['cellLat']),
      cellLon: serializer.fromJson<double>(json['cellLon']),
      conditionsHash: serializer.fromJson<String>(json['conditionsHash']),
      score: serializer.fromJson<double>(json['score']),
      reasoningJson: serializer.fromJson<String>(json['reasoningJson']),
      computedAtUtc: serializer.fromJson<int>(json['computedAtUtc']),
      validUntilUtc: serializer.fromJson<int>(json['validUntilUtc']),
      lastAccessedUtc: serializer.fromJson<int>(json['lastAccessedUtc']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'cacheKey': serializer.toJson<String>(cacheKey),
      'speciesId': serializer.toJson<String>(speciesId),
      'cellLat': serializer.toJson<double>(cellLat),
      'cellLon': serializer.toJson<double>(cellLon),
      'conditionsHash': serializer.toJson<String>(conditionsHash),
      'score': serializer.toJson<double>(score),
      'reasoningJson': serializer.toJson<String>(reasoningJson),
      'computedAtUtc': serializer.toJson<int>(computedAtUtc),
      'validUntilUtc': serializer.toJson<int>(validUntilUtc),
      'lastAccessedUtc': serializer.toJson<int>(lastAccessedUtc),
    };
  }

  ScoreCacheRow copyWith(
          {String? cacheKey,
          String? speciesId,
          double? cellLat,
          double? cellLon,
          String? conditionsHash,
          double? score,
          String? reasoningJson,
          int? computedAtUtc,
          int? validUntilUtc,
          int? lastAccessedUtc}) =>
      ScoreCacheRow(
        cacheKey: cacheKey ?? this.cacheKey,
        speciesId: speciesId ?? this.speciesId,
        cellLat: cellLat ?? this.cellLat,
        cellLon: cellLon ?? this.cellLon,
        conditionsHash: conditionsHash ?? this.conditionsHash,
        score: score ?? this.score,
        reasoningJson: reasoningJson ?? this.reasoningJson,
        computedAtUtc: computedAtUtc ?? this.computedAtUtc,
        validUntilUtc: validUntilUtc ?? this.validUntilUtc,
        lastAccessedUtc: lastAccessedUtc ?? this.lastAccessedUtc,
      );
  ScoreCacheRow copyWithCompanion(ScoreCacheCompanion data) {
    return ScoreCacheRow(
      cacheKey: data.cacheKey.present ? data.cacheKey.value : this.cacheKey,
      speciesId: data.speciesId.present ? data.speciesId.value : this.speciesId,
      cellLat: data.cellLat.present ? data.cellLat.value : this.cellLat,
      cellLon: data.cellLon.present ? data.cellLon.value : this.cellLon,
      conditionsHash: data.conditionsHash.present
          ? data.conditionsHash.value
          : this.conditionsHash,
      score: data.score.present ? data.score.value : this.score,
      reasoningJson: data.reasoningJson.present
          ? data.reasoningJson.value
          : this.reasoningJson,
      computedAtUtc: data.computedAtUtc.present
          ? data.computedAtUtc.value
          : this.computedAtUtc,
      validUntilUtc: data.validUntilUtc.present
          ? data.validUntilUtc.value
          : this.validUntilUtc,
      lastAccessedUtc: data.lastAccessedUtc.present
          ? data.lastAccessedUtc.value
          : this.lastAccessedUtc,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ScoreCacheRow(')
          ..write('cacheKey: $cacheKey, ')
          ..write('speciesId: $speciesId, ')
          ..write('cellLat: $cellLat, ')
          ..write('cellLon: $cellLon, ')
          ..write('conditionsHash: $conditionsHash, ')
          ..write('score: $score, ')
          ..write('reasoningJson: $reasoningJson, ')
          ..write('computedAtUtc: $computedAtUtc, ')
          ..write('validUntilUtc: $validUntilUtc, ')
          ..write('lastAccessedUtc: $lastAccessedUtc')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      cacheKey,
      speciesId,
      cellLat,
      cellLon,
      conditionsHash,
      score,
      reasoningJson,
      computedAtUtc,
      validUntilUtc,
      lastAccessedUtc);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ScoreCacheRow &&
          other.cacheKey == this.cacheKey &&
          other.speciesId == this.speciesId &&
          other.cellLat == this.cellLat &&
          other.cellLon == this.cellLon &&
          other.conditionsHash == this.conditionsHash &&
          other.score == this.score &&
          other.reasoningJson == this.reasoningJson &&
          other.computedAtUtc == this.computedAtUtc &&
          other.validUntilUtc == this.validUntilUtc &&
          other.lastAccessedUtc == this.lastAccessedUtc);
}

class ScoreCacheCompanion extends UpdateCompanion<ScoreCacheRow> {
  final Value<String> cacheKey;
  final Value<String> speciesId;
  final Value<double> cellLat;
  final Value<double> cellLon;
  final Value<String> conditionsHash;
  final Value<double> score;
  final Value<String> reasoningJson;
  final Value<int> computedAtUtc;
  final Value<int> validUntilUtc;
  final Value<int> lastAccessedUtc;
  final Value<int> rowid;
  const ScoreCacheCompanion({
    this.cacheKey = const Value.absent(),
    this.speciesId = const Value.absent(),
    this.cellLat = const Value.absent(),
    this.cellLon = const Value.absent(),
    this.conditionsHash = const Value.absent(),
    this.score = const Value.absent(),
    this.reasoningJson = const Value.absent(),
    this.computedAtUtc = const Value.absent(),
    this.validUntilUtc = const Value.absent(),
    this.lastAccessedUtc = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ScoreCacheCompanion.insert({
    required String cacheKey,
    required String speciesId,
    required double cellLat,
    required double cellLon,
    required String conditionsHash,
    required double score,
    required String reasoningJson,
    required int computedAtUtc,
    required int validUntilUtc,
    required int lastAccessedUtc,
    this.rowid = const Value.absent(),
  })  : cacheKey = Value(cacheKey),
        speciesId = Value(speciesId),
        cellLat = Value(cellLat),
        cellLon = Value(cellLon),
        conditionsHash = Value(conditionsHash),
        score = Value(score),
        reasoningJson = Value(reasoningJson),
        computedAtUtc = Value(computedAtUtc),
        validUntilUtc = Value(validUntilUtc),
        lastAccessedUtc = Value(lastAccessedUtc);
  static Insertable<ScoreCacheRow> custom({
    Expression<String>? cacheKey,
    Expression<String>? speciesId,
    Expression<double>? cellLat,
    Expression<double>? cellLon,
    Expression<String>? conditionsHash,
    Expression<double>? score,
    Expression<String>? reasoningJson,
    Expression<int>? computedAtUtc,
    Expression<int>? validUntilUtc,
    Expression<int>? lastAccessedUtc,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (cacheKey != null) 'cache_key': cacheKey,
      if (speciesId != null) 'species_id': speciesId,
      if (cellLat != null) 'cell_lat': cellLat,
      if (cellLon != null) 'cell_lon': cellLon,
      if (conditionsHash != null) 'conditions_hash': conditionsHash,
      if (score != null) 'score': score,
      if (reasoningJson != null) 'reasoning_json': reasoningJson,
      if (computedAtUtc != null) 'computed_at_utc': computedAtUtc,
      if (validUntilUtc != null) 'valid_until_utc': validUntilUtc,
      if (lastAccessedUtc != null) 'last_accessed_utc': lastAccessedUtc,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ScoreCacheCompanion copyWith(
      {Value<String>? cacheKey,
      Value<String>? speciesId,
      Value<double>? cellLat,
      Value<double>? cellLon,
      Value<String>? conditionsHash,
      Value<double>? score,
      Value<String>? reasoningJson,
      Value<int>? computedAtUtc,
      Value<int>? validUntilUtc,
      Value<int>? lastAccessedUtc,
      Value<int>? rowid}) {
    return ScoreCacheCompanion(
      cacheKey: cacheKey ?? this.cacheKey,
      speciesId: speciesId ?? this.speciesId,
      cellLat: cellLat ?? this.cellLat,
      cellLon: cellLon ?? this.cellLon,
      conditionsHash: conditionsHash ?? this.conditionsHash,
      score: score ?? this.score,
      reasoningJson: reasoningJson ?? this.reasoningJson,
      computedAtUtc: computedAtUtc ?? this.computedAtUtc,
      validUntilUtc: validUntilUtc ?? this.validUntilUtc,
      lastAccessedUtc: lastAccessedUtc ?? this.lastAccessedUtc,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (cacheKey.present) {
      map['cache_key'] = Variable<String>(cacheKey.value);
    }
    if (speciesId.present) {
      map['species_id'] = Variable<String>(speciesId.value);
    }
    if (cellLat.present) {
      map['cell_lat'] = Variable<double>(cellLat.value);
    }
    if (cellLon.present) {
      map['cell_lon'] = Variable<double>(cellLon.value);
    }
    if (conditionsHash.present) {
      map['conditions_hash'] = Variable<String>(conditionsHash.value);
    }
    if (score.present) {
      map['score'] = Variable<double>(score.value);
    }
    if (reasoningJson.present) {
      map['reasoning_json'] = Variable<String>(reasoningJson.value);
    }
    if (computedAtUtc.present) {
      map['computed_at_utc'] = Variable<int>(computedAtUtc.value);
    }
    if (validUntilUtc.present) {
      map['valid_until_utc'] = Variable<int>(validUntilUtc.value);
    }
    if (lastAccessedUtc.present) {
      map['last_accessed_utc'] = Variable<int>(lastAccessedUtc.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ScoreCacheCompanion(')
          ..write('cacheKey: $cacheKey, ')
          ..write('speciesId: $speciesId, ')
          ..write('cellLat: $cellLat, ')
          ..write('cellLon: $cellLon, ')
          ..write('conditionsHash: $conditionsHash, ')
          ..write('score: $score, ')
          ..write('reasoningJson: $reasoningJson, ')
          ..write('computedAtUtc: $computedAtUtc, ')
          ..write('validUntilUtc: $validUntilUtc, ')
          ..write('lastAccessedUtc: $lastAccessedUtc, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ChartTileCacheTable extends ChartTileCache
    with TableInfo<$ChartTileCacheTable, ChartTileCacheRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChartTileCacheTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _cacheKeyMeta =
      const VerificationMeta('cacheKey');
  @override
  late final GeneratedColumn<String> cacheKey = GeneratedColumn<String>(
      'cache_key', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _zoomMeta = const VerificationMeta('zoom');
  @override
  late final GeneratedColumn<int> zoom = GeneratedColumn<int>(
      'zoom', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _xMeta = const VerificationMeta('x');
  @override
  late final GeneratedColumn<int> x = GeneratedColumn<int>(
      'x', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _yMeta = const VerificationMeta('y');
  @override
  late final GeneratedColumn<int> y = GeneratedColumn<int>(
      'y', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _chartRevisionMeta =
      const VerificationMeta('chartRevision');
  @override
  late final GeneratedColumn<String> chartRevision = GeneratedColumn<String>(
      'chart_revision', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _tileBlobMeta =
      const VerificationMeta('tileBlob');
  @override
  late final GeneratedColumn<Uint8List> tileBlob = GeneratedColumn<Uint8List>(
      'tile_blob', aliasedName, false,
      type: DriftSqlType.blob, requiredDuringInsert: true);
  static const VerificationMeta _sizeBytesMeta =
      const VerificationMeta('sizeBytes');
  @override
  late final GeneratedColumn<int> sizeBytes = GeneratedColumn<int>(
      'size_bytes', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _fetchedAtUtcMeta =
      const VerificationMeta('fetchedAtUtc');
  @override
  late final GeneratedColumn<int> fetchedAtUtc = GeneratedColumn<int>(
      'fetched_at_utc', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _lastAccessedUtcMeta =
      const VerificationMeta('lastAccessedUtc');
  @override
  late final GeneratedColumn<int> lastAccessedUtc = GeneratedColumn<int>(
      'last_accessed_utc', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _pinnedMeta = const VerificationMeta('pinned');
  @override
  late final GeneratedColumn<bool> pinned = GeneratedColumn<bool>(
      'pinned', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("pinned" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        cacheKey,
        zoom,
        x,
        y,
        chartRevision,
        tileBlob,
        sizeBytes,
        fetchedAtUtc,
        lastAccessedUtc,
        pinned
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'chart_tile_cache';
  @override
  VerificationContext validateIntegrity(Insertable<ChartTileCacheRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('cache_key')) {
      context.handle(_cacheKeyMeta,
          cacheKey.isAcceptableOrUnknown(data['cache_key']!, _cacheKeyMeta));
    } else if (isInserting) {
      context.missing(_cacheKeyMeta);
    }
    if (data.containsKey('zoom')) {
      context.handle(
          _zoomMeta, zoom.isAcceptableOrUnknown(data['zoom']!, _zoomMeta));
    } else if (isInserting) {
      context.missing(_zoomMeta);
    }
    if (data.containsKey('x')) {
      context.handle(_xMeta, x.isAcceptableOrUnknown(data['x']!, _xMeta));
    } else if (isInserting) {
      context.missing(_xMeta);
    }
    if (data.containsKey('y')) {
      context.handle(_yMeta, y.isAcceptableOrUnknown(data['y']!, _yMeta));
    } else if (isInserting) {
      context.missing(_yMeta);
    }
    if (data.containsKey('chart_revision')) {
      context.handle(
          _chartRevisionMeta,
          chartRevision.isAcceptableOrUnknown(
              data['chart_revision']!, _chartRevisionMeta));
    } else if (isInserting) {
      context.missing(_chartRevisionMeta);
    }
    if (data.containsKey('tile_blob')) {
      context.handle(_tileBlobMeta,
          tileBlob.isAcceptableOrUnknown(data['tile_blob']!, _tileBlobMeta));
    } else if (isInserting) {
      context.missing(_tileBlobMeta);
    }
    if (data.containsKey('size_bytes')) {
      context.handle(_sizeBytesMeta,
          sizeBytes.isAcceptableOrUnknown(data['size_bytes']!, _sizeBytesMeta));
    } else if (isInserting) {
      context.missing(_sizeBytesMeta);
    }
    if (data.containsKey('fetched_at_utc')) {
      context.handle(
          _fetchedAtUtcMeta,
          fetchedAtUtc.isAcceptableOrUnknown(
              data['fetched_at_utc']!, _fetchedAtUtcMeta));
    } else if (isInserting) {
      context.missing(_fetchedAtUtcMeta);
    }
    if (data.containsKey('last_accessed_utc')) {
      context.handle(
          _lastAccessedUtcMeta,
          lastAccessedUtc.isAcceptableOrUnknown(
              data['last_accessed_utc']!, _lastAccessedUtcMeta));
    } else if (isInserting) {
      context.missing(_lastAccessedUtcMeta);
    }
    if (data.containsKey('pinned')) {
      context.handle(_pinnedMeta,
          pinned.isAcceptableOrUnknown(data['pinned']!, _pinnedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {cacheKey};
  @override
  ChartTileCacheRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChartTileCacheRow(
      cacheKey: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cache_key'])!,
      zoom: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}zoom'])!,
      x: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}x'])!,
      y: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}y'])!,
      chartRevision: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}chart_revision'])!,
      tileBlob: attachedDatabase.typeMapping
          .read(DriftSqlType.blob, data['${effectivePrefix}tile_blob'])!,
      sizeBytes: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}size_bytes'])!,
      fetchedAtUtc: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}fetched_at_utc'])!,
      lastAccessedUtc: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}last_accessed_utc'])!,
      pinned: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}pinned'])!,
    );
  }

  @override
  $ChartTileCacheTable createAlias(String alias) {
    return $ChartTileCacheTable(attachedDatabase, alias);
  }
}

class ChartTileCacheRow extends DataClass
    implements Insertable<ChartTileCacheRow> {
  final String cacheKey;
  final int zoom;
  final int x;
  final int y;
  final String chartRevision;
  final Uint8List tileBlob;
  final int sizeBytes;
  final int fetchedAtUtc;
  final int lastAccessedUtc;
  final bool pinned;
  const ChartTileCacheRow(
      {required this.cacheKey,
      required this.zoom,
      required this.x,
      required this.y,
      required this.chartRevision,
      required this.tileBlob,
      required this.sizeBytes,
      required this.fetchedAtUtc,
      required this.lastAccessedUtc,
      required this.pinned});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['cache_key'] = Variable<String>(cacheKey);
    map['zoom'] = Variable<int>(zoom);
    map['x'] = Variable<int>(x);
    map['y'] = Variable<int>(y);
    map['chart_revision'] = Variable<String>(chartRevision);
    map['tile_blob'] = Variable<Uint8List>(tileBlob);
    map['size_bytes'] = Variable<int>(sizeBytes);
    map['fetched_at_utc'] = Variable<int>(fetchedAtUtc);
    map['last_accessed_utc'] = Variable<int>(lastAccessedUtc);
    map['pinned'] = Variable<bool>(pinned);
    return map;
  }

  ChartTileCacheCompanion toCompanion(bool nullToAbsent) {
    return ChartTileCacheCompanion(
      cacheKey: Value(cacheKey),
      zoom: Value(zoom),
      x: Value(x),
      y: Value(y),
      chartRevision: Value(chartRevision),
      tileBlob: Value(tileBlob),
      sizeBytes: Value(sizeBytes),
      fetchedAtUtc: Value(fetchedAtUtc),
      lastAccessedUtc: Value(lastAccessedUtc),
      pinned: Value(pinned),
    );
  }

  factory ChartTileCacheRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChartTileCacheRow(
      cacheKey: serializer.fromJson<String>(json['cacheKey']),
      zoom: serializer.fromJson<int>(json['zoom']),
      x: serializer.fromJson<int>(json['x']),
      y: serializer.fromJson<int>(json['y']),
      chartRevision: serializer.fromJson<String>(json['chartRevision']),
      tileBlob: serializer.fromJson<Uint8List>(json['tileBlob']),
      sizeBytes: serializer.fromJson<int>(json['sizeBytes']),
      fetchedAtUtc: serializer.fromJson<int>(json['fetchedAtUtc']),
      lastAccessedUtc: serializer.fromJson<int>(json['lastAccessedUtc']),
      pinned: serializer.fromJson<bool>(json['pinned']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'cacheKey': serializer.toJson<String>(cacheKey),
      'zoom': serializer.toJson<int>(zoom),
      'x': serializer.toJson<int>(x),
      'y': serializer.toJson<int>(y),
      'chartRevision': serializer.toJson<String>(chartRevision),
      'tileBlob': serializer.toJson<Uint8List>(tileBlob),
      'sizeBytes': serializer.toJson<int>(sizeBytes),
      'fetchedAtUtc': serializer.toJson<int>(fetchedAtUtc),
      'lastAccessedUtc': serializer.toJson<int>(lastAccessedUtc),
      'pinned': serializer.toJson<bool>(pinned),
    };
  }

  ChartTileCacheRow copyWith(
          {String? cacheKey,
          int? zoom,
          int? x,
          int? y,
          String? chartRevision,
          Uint8List? tileBlob,
          int? sizeBytes,
          int? fetchedAtUtc,
          int? lastAccessedUtc,
          bool? pinned}) =>
      ChartTileCacheRow(
        cacheKey: cacheKey ?? this.cacheKey,
        zoom: zoom ?? this.zoom,
        x: x ?? this.x,
        y: y ?? this.y,
        chartRevision: chartRevision ?? this.chartRevision,
        tileBlob: tileBlob ?? this.tileBlob,
        sizeBytes: sizeBytes ?? this.sizeBytes,
        fetchedAtUtc: fetchedAtUtc ?? this.fetchedAtUtc,
        lastAccessedUtc: lastAccessedUtc ?? this.lastAccessedUtc,
        pinned: pinned ?? this.pinned,
      );
  ChartTileCacheRow copyWithCompanion(ChartTileCacheCompanion data) {
    return ChartTileCacheRow(
      cacheKey: data.cacheKey.present ? data.cacheKey.value : this.cacheKey,
      zoom: data.zoom.present ? data.zoom.value : this.zoom,
      x: data.x.present ? data.x.value : this.x,
      y: data.y.present ? data.y.value : this.y,
      chartRevision: data.chartRevision.present
          ? data.chartRevision.value
          : this.chartRevision,
      tileBlob: data.tileBlob.present ? data.tileBlob.value : this.tileBlob,
      sizeBytes: data.sizeBytes.present ? data.sizeBytes.value : this.sizeBytes,
      fetchedAtUtc: data.fetchedAtUtc.present
          ? data.fetchedAtUtc.value
          : this.fetchedAtUtc,
      lastAccessedUtc: data.lastAccessedUtc.present
          ? data.lastAccessedUtc.value
          : this.lastAccessedUtc,
      pinned: data.pinned.present ? data.pinned.value : this.pinned,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChartTileCacheRow(')
          ..write('cacheKey: $cacheKey, ')
          ..write('zoom: $zoom, ')
          ..write('x: $x, ')
          ..write('y: $y, ')
          ..write('chartRevision: $chartRevision, ')
          ..write('tileBlob: $tileBlob, ')
          ..write('sizeBytes: $sizeBytes, ')
          ..write('fetchedAtUtc: $fetchedAtUtc, ')
          ..write('lastAccessedUtc: $lastAccessedUtc, ')
          ..write('pinned: $pinned')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      cacheKey,
      zoom,
      x,
      y,
      chartRevision,
      $driftBlobEquality.hash(tileBlob),
      sizeBytes,
      fetchedAtUtc,
      lastAccessedUtc,
      pinned);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChartTileCacheRow &&
          other.cacheKey == this.cacheKey &&
          other.zoom == this.zoom &&
          other.x == this.x &&
          other.y == this.y &&
          other.chartRevision == this.chartRevision &&
          $driftBlobEquality.equals(other.tileBlob, this.tileBlob) &&
          other.sizeBytes == this.sizeBytes &&
          other.fetchedAtUtc == this.fetchedAtUtc &&
          other.lastAccessedUtc == this.lastAccessedUtc &&
          other.pinned == this.pinned);
}

class ChartTileCacheCompanion extends UpdateCompanion<ChartTileCacheRow> {
  final Value<String> cacheKey;
  final Value<int> zoom;
  final Value<int> x;
  final Value<int> y;
  final Value<String> chartRevision;
  final Value<Uint8List> tileBlob;
  final Value<int> sizeBytes;
  final Value<int> fetchedAtUtc;
  final Value<int> lastAccessedUtc;
  final Value<bool> pinned;
  final Value<int> rowid;
  const ChartTileCacheCompanion({
    this.cacheKey = const Value.absent(),
    this.zoom = const Value.absent(),
    this.x = const Value.absent(),
    this.y = const Value.absent(),
    this.chartRevision = const Value.absent(),
    this.tileBlob = const Value.absent(),
    this.sizeBytes = const Value.absent(),
    this.fetchedAtUtc = const Value.absent(),
    this.lastAccessedUtc = const Value.absent(),
    this.pinned = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ChartTileCacheCompanion.insert({
    required String cacheKey,
    required int zoom,
    required int x,
    required int y,
    required String chartRevision,
    required Uint8List tileBlob,
    required int sizeBytes,
    required int fetchedAtUtc,
    required int lastAccessedUtc,
    this.pinned = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : cacheKey = Value(cacheKey),
        zoom = Value(zoom),
        x = Value(x),
        y = Value(y),
        chartRevision = Value(chartRevision),
        tileBlob = Value(tileBlob),
        sizeBytes = Value(sizeBytes),
        fetchedAtUtc = Value(fetchedAtUtc),
        lastAccessedUtc = Value(lastAccessedUtc);
  static Insertable<ChartTileCacheRow> custom({
    Expression<String>? cacheKey,
    Expression<int>? zoom,
    Expression<int>? x,
    Expression<int>? y,
    Expression<String>? chartRevision,
    Expression<Uint8List>? tileBlob,
    Expression<int>? sizeBytes,
    Expression<int>? fetchedAtUtc,
    Expression<int>? lastAccessedUtc,
    Expression<bool>? pinned,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (cacheKey != null) 'cache_key': cacheKey,
      if (zoom != null) 'zoom': zoom,
      if (x != null) 'x': x,
      if (y != null) 'y': y,
      if (chartRevision != null) 'chart_revision': chartRevision,
      if (tileBlob != null) 'tile_blob': tileBlob,
      if (sizeBytes != null) 'size_bytes': sizeBytes,
      if (fetchedAtUtc != null) 'fetched_at_utc': fetchedAtUtc,
      if (lastAccessedUtc != null) 'last_accessed_utc': lastAccessedUtc,
      if (pinned != null) 'pinned': pinned,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ChartTileCacheCompanion copyWith(
      {Value<String>? cacheKey,
      Value<int>? zoom,
      Value<int>? x,
      Value<int>? y,
      Value<String>? chartRevision,
      Value<Uint8List>? tileBlob,
      Value<int>? sizeBytes,
      Value<int>? fetchedAtUtc,
      Value<int>? lastAccessedUtc,
      Value<bool>? pinned,
      Value<int>? rowid}) {
    return ChartTileCacheCompanion(
      cacheKey: cacheKey ?? this.cacheKey,
      zoom: zoom ?? this.zoom,
      x: x ?? this.x,
      y: y ?? this.y,
      chartRevision: chartRevision ?? this.chartRevision,
      tileBlob: tileBlob ?? this.tileBlob,
      sizeBytes: sizeBytes ?? this.sizeBytes,
      fetchedAtUtc: fetchedAtUtc ?? this.fetchedAtUtc,
      lastAccessedUtc: lastAccessedUtc ?? this.lastAccessedUtc,
      pinned: pinned ?? this.pinned,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (cacheKey.present) {
      map['cache_key'] = Variable<String>(cacheKey.value);
    }
    if (zoom.present) {
      map['zoom'] = Variable<int>(zoom.value);
    }
    if (x.present) {
      map['x'] = Variable<int>(x.value);
    }
    if (y.present) {
      map['y'] = Variable<int>(y.value);
    }
    if (chartRevision.present) {
      map['chart_revision'] = Variable<String>(chartRevision.value);
    }
    if (tileBlob.present) {
      map['tile_blob'] = Variable<Uint8List>(tileBlob.value);
    }
    if (sizeBytes.present) {
      map['size_bytes'] = Variable<int>(sizeBytes.value);
    }
    if (fetchedAtUtc.present) {
      map['fetched_at_utc'] = Variable<int>(fetchedAtUtc.value);
    }
    if (lastAccessedUtc.present) {
      map['last_accessed_utc'] = Variable<int>(lastAccessedUtc.value);
    }
    if (pinned.present) {
      map['pinned'] = Variable<bool>(pinned.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChartTileCacheCompanion(')
          ..write('cacheKey: $cacheKey, ')
          ..write('zoom: $zoom, ')
          ..write('x: $x, ')
          ..write('y: $y, ')
          ..write('chartRevision: $chartRevision, ')
          ..write('tileBlob: $tileBlob, ')
          ..write('sizeBytes: $sizeBytes, ')
          ..write('fetchedAtUtc: $fetchedAtUtc, ')
          ..write('lastAccessedUtc: $lastAccessedUtc, ')
          ..write('pinned: $pinned, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ForecastCacheTable extends ForecastCache
    with TableInfo<$ForecastCacheTable, ForecastCacheRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ForecastCacheTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _cacheKeyMeta =
      const VerificationMeta('cacheKey');
  @override
  late final GeneratedColumn<String> cacheKey = GeneratedColumn<String>(
      'cache_key', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _zoneIdMeta = const VerificationMeta('zoneId');
  @override
  late final GeneratedColumn<String> zoneId = GeneratedColumn<String>(
      'zone_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dayBucketMeta =
      const VerificationMeta('dayBucket');
  @override
  late final GeneratedColumn<String> dayBucket = GeneratedColumn<String>(
      'day_bucket', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _forecastJsonMeta =
      const VerificationMeta('forecastJson');
  @override
  late final GeneratedColumn<String> forecastJson = GeneratedColumn<String>(
      'forecast_json', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _fetchedAtUtcMeta =
      const VerificationMeta('fetchedAtUtc');
  @override
  late final GeneratedColumn<int> fetchedAtUtc = GeneratedColumn<int>(
      'fetched_at_utc', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _validUntilUtcMeta =
      const VerificationMeta('validUntilUtc');
  @override
  late final GeneratedColumn<int> validUntilUtc = GeneratedColumn<int>(
      'valid_until_utc', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _sizeBytesMeta =
      const VerificationMeta('sizeBytes');
  @override
  late final GeneratedColumn<int> sizeBytes = GeneratedColumn<int>(
      'size_bytes', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _lastAccessedUtcMeta =
      const VerificationMeta('lastAccessedUtc');
  @override
  late final GeneratedColumn<int> lastAccessedUtc = GeneratedColumn<int>(
      'last_accessed_utc', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _pinnedMeta = const VerificationMeta('pinned');
  @override
  late final GeneratedColumn<bool> pinned = GeneratedColumn<bool>(
      'pinned', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("pinned" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        cacheKey,
        zoneId,
        dayBucket,
        forecastJson,
        fetchedAtUtc,
        validUntilUtc,
        sizeBytes,
        lastAccessedUtc,
        pinned
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'forecast_cache';
  @override
  VerificationContext validateIntegrity(Insertable<ForecastCacheRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('cache_key')) {
      context.handle(_cacheKeyMeta,
          cacheKey.isAcceptableOrUnknown(data['cache_key']!, _cacheKeyMeta));
    } else if (isInserting) {
      context.missing(_cacheKeyMeta);
    }
    if (data.containsKey('zone_id')) {
      context.handle(_zoneIdMeta,
          zoneId.isAcceptableOrUnknown(data['zone_id']!, _zoneIdMeta));
    } else if (isInserting) {
      context.missing(_zoneIdMeta);
    }
    if (data.containsKey('day_bucket')) {
      context.handle(_dayBucketMeta,
          dayBucket.isAcceptableOrUnknown(data['day_bucket']!, _dayBucketMeta));
    } else if (isInserting) {
      context.missing(_dayBucketMeta);
    }
    if (data.containsKey('forecast_json')) {
      context.handle(
          _forecastJsonMeta,
          forecastJson.isAcceptableOrUnknown(
              data['forecast_json']!, _forecastJsonMeta));
    } else if (isInserting) {
      context.missing(_forecastJsonMeta);
    }
    if (data.containsKey('fetched_at_utc')) {
      context.handle(
          _fetchedAtUtcMeta,
          fetchedAtUtc.isAcceptableOrUnknown(
              data['fetched_at_utc']!, _fetchedAtUtcMeta));
    } else if (isInserting) {
      context.missing(_fetchedAtUtcMeta);
    }
    if (data.containsKey('valid_until_utc')) {
      context.handle(
          _validUntilUtcMeta,
          validUntilUtc.isAcceptableOrUnknown(
              data['valid_until_utc']!, _validUntilUtcMeta));
    } else if (isInserting) {
      context.missing(_validUntilUtcMeta);
    }
    if (data.containsKey('size_bytes')) {
      context.handle(_sizeBytesMeta,
          sizeBytes.isAcceptableOrUnknown(data['size_bytes']!, _sizeBytesMeta));
    } else if (isInserting) {
      context.missing(_sizeBytesMeta);
    }
    if (data.containsKey('last_accessed_utc')) {
      context.handle(
          _lastAccessedUtcMeta,
          lastAccessedUtc.isAcceptableOrUnknown(
              data['last_accessed_utc']!, _lastAccessedUtcMeta));
    } else if (isInserting) {
      context.missing(_lastAccessedUtcMeta);
    }
    if (data.containsKey('pinned')) {
      context.handle(_pinnedMeta,
          pinned.isAcceptableOrUnknown(data['pinned']!, _pinnedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {cacheKey};
  @override
  ForecastCacheRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ForecastCacheRow(
      cacheKey: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cache_key'])!,
      zoneId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}zone_id'])!,
      dayBucket: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}day_bucket'])!,
      forecastJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}forecast_json'])!,
      fetchedAtUtc: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}fetched_at_utc'])!,
      validUntilUtc: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}valid_until_utc'])!,
      sizeBytes: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}size_bytes'])!,
      lastAccessedUtc: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}last_accessed_utc'])!,
      pinned: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}pinned'])!,
    );
  }

  @override
  $ForecastCacheTable createAlias(String alias) {
    return $ForecastCacheTable(attachedDatabase, alias);
  }
}

class ForecastCacheRow extends DataClass
    implements Insertable<ForecastCacheRow> {
  final String cacheKey;
  final String zoneId;
  final String dayBucket;
  final String forecastJson;
  final int fetchedAtUtc;
  final int validUntilUtc;
  final int sizeBytes;
  final int lastAccessedUtc;
  final bool pinned;
  const ForecastCacheRow(
      {required this.cacheKey,
      required this.zoneId,
      required this.dayBucket,
      required this.forecastJson,
      required this.fetchedAtUtc,
      required this.validUntilUtc,
      required this.sizeBytes,
      required this.lastAccessedUtc,
      required this.pinned});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['cache_key'] = Variable<String>(cacheKey);
    map['zone_id'] = Variable<String>(zoneId);
    map['day_bucket'] = Variable<String>(dayBucket);
    map['forecast_json'] = Variable<String>(forecastJson);
    map['fetched_at_utc'] = Variable<int>(fetchedAtUtc);
    map['valid_until_utc'] = Variable<int>(validUntilUtc);
    map['size_bytes'] = Variable<int>(sizeBytes);
    map['last_accessed_utc'] = Variable<int>(lastAccessedUtc);
    map['pinned'] = Variable<bool>(pinned);
    return map;
  }

  ForecastCacheCompanion toCompanion(bool nullToAbsent) {
    return ForecastCacheCompanion(
      cacheKey: Value(cacheKey),
      zoneId: Value(zoneId),
      dayBucket: Value(dayBucket),
      forecastJson: Value(forecastJson),
      fetchedAtUtc: Value(fetchedAtUtc),
      validUntilUtc: Value(validUntilUtc),
      sizeBytes: Value(sizeBytes),
      lastAccessedUtc: Value(lastAccessedUtc),
      pinned: Value(pinned),
    );
  }

  factory ForecastCacheRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ForecastCacheRow(
      cacheKey: serializer.fromJson<String>(json['cacheKey']),
      zoneId: serializer.fromJson<String>(json['zoneId']),
      dayBucket: serializer.fromJson<String>(json['dayBucket']),
      forecastJson: serializer.fromJson<String>(json['forecastJson']),
      fetchedAtUtc: serializer.fromJson<int>(json['fetchedAtUtc']),
      validUntilUtc: serializer.fromJson<int>(json['validUntilUtc']),
      sizeBytes: serializer.fromJson<int>(json['sizeBytes']),
      lastAccessedUtc: serializer.fromJson<int>(json['lastAccessedUtc']),
      pinned: serializer.fromJson<bool>(json['pinned']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'cacheKey': serializer.toJson<String>(cacheKey),
      'zoneId': serializer.toJson<String>(zoneId),
      'dayBucket': serializer.toJson<String>(dayBucket),
      'forecastJson': serializer.toJson<String>(forecastJson),
      'fetchedAtUtc': serializer.toJson<int>(fetchedAtUtc),
      'validUntilUtc': serializer.toJson<int>(validUntilUtc),
      'sizeBytes': serializer.toJson<int>(sizeBytes),
      'lastAccessedUtc': serializer.toJson<int>(lastAccessedUtc),
      'pinned': serializer.toJson<bool>(pinned),
    };
  }

  ForecastCacheRow copyWith(
          {String? cacheKey,
          String? zoneId,
          String? dayBucket,
          String? forecastJson,
          int? fetchedAtUtc,
          int? validUntilUtc,
          int? sizeBytes,
          int? lastAccessedUtc,
          bool? pinned}) =>
      ForecastCacheRow(
        cacheKey: cacheKey ?? this.cacheKey,
        zoneId: zoneId ?? this.zoneId,
        dayBucket: dayBucket ?? this.dayBucket,
        forecastJson: forecastJson ?? this.forecastJson,
        fetchedAtUtc: fetchedAtUtc ?? this.fetchedAtUtc,
        validUntilUtc: validUntilUtc ?? this.validUntilUtc,
        sizeBytes: sizeBytes ?? this.sizeBytes,
        lastAccessedUtc: lastAccessedUtc ?? this.lastAccessedUtc,
        pinned: pinned ?? this.pinned,
      );
  ForecastCacheRow copyWithCompanion(ForecastCacheCompanion data) {
    return ForecastCacheRow(
      cacheKey: data.cacheKey.present ? data.cacheKey.value : this.cacheKey,
      zoneId: data.zoneId.present ? data.zoneId.value : this.zoneId,
      dayBucket: data.dayBucket.present ? data.dayBucket.value : this.dayBucket,
      forecastJson: data.forecastJson.present
          ? data.forecastJson.value
          : this.forecastJson,
      fetchedAtUtc: data.fetchedAtUtc.present
          ? data.fetchedAtUtc.value
          : this.fetchedAtUtc,
      validUntilUtc: data.validUntilUtc.present
          ? data.validUntilUtc.value
          : this.validUntilUtc,
      sizeBytes: data.sizeBytes.present ? data.sizeBytes.value : this.sizeBytes,
      lastAccessedUtc: data.lastAccessedUtc.present
          ? data.lastAccessedUtc.value
          : this.lastAccessedUtc,
      pinned: data.pinned.present ? data.pinned.value : this.pinned,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ForecastCacheRow(')
          ..write('cacheKey: $cacheKey, ')
          ..write('zoneId: $zoneId, ')
          ..write('dayBucket: $dayBucket, ')
          ..write('forecastJson: $forecastJson, ')
          ..write('fetchedAtUtc: $fetchedAtUtc, ')
          ..write('validUntilUtc: $validUntilUtc, ')
          ..write('sizeBytes: $sizeBytes, ')
          ..write('lastAccessedUtc: $lastAccessedUtc, ')
          ..write('pinned: $pinned')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(cacheKey, zoneId, dayBucket, forecastJson,
      fetchedAtUtc, validUntilUtc, sizeBytes, lastAccessedUtc, pinned);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ForecastCacheRow &&
          other.cacheKey == this.cacheKey &&
          other.zoneId == this.zoneId &&
          other.dayBucket == this.dayBucket &&
          other.forecastJson == this.forecastJson &&
          other.fetchedAtUtc == this.fetchedAtUtc &&
          other.validUntilUtc == this.validUntilUtc &&
          other.sizeBytes == this.sizeBytes &&
          other.lastAccessedUtc == this.lastAccessedUtc &&
          other.pinned == this.pinned);
}

class ForecastCacheCompanion extends UpdateCompanion<ForecastCacheRow> {
  final Value<String> cacheKey;
  final Value<String> zoneId;
  final Value<String> dayBucket;
  final Value<String> forecastJson;
  final Value<int> fetchedAtUtc;
  final Value<int> validUntilUtc;
  final Value<int> sizeBytes;
  final Value<int> lastAccessedUtc;
  final Value<bool> pinned;
  final Value<int> rowid;
  const ForecastCacheCompanion({
    this.cacheKey = const Value.absent(),
    this.zoneId = const Value.absent(),
    this.dayBucket = const Value.absent(),
    this.forecastJson = const Value.absent(),
    this.fetchedAtUtc = const Value.absent(),
    this.validUntilUtc = const Value.absent(),
    this.sizeBytes = const Value.absent(),
    this.lastAccessedUtc = const Value.absent(),
    this.pinned = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ForecastCacheCompanion.insert({
    required String cacheKey,
    required String zoneId,
    required String dayBucket,
    required String forecastJson,
    required int fetchedAtUtc,
    required int validUntilUtc,
    required int sizeBytes,
    required int lastAccessedUtc,
    this.pinned = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : cacheKey = Value(cacheKey),
        zoneId = Value(zoneId),
        dayBucket = Value(dayBucket),
        forecastJson = Value(forecastJson),
        fetchedAtUtc = Value(fetchedAtUtc),
        validUntilUtc = Value(validUntilUtc),
        sizeBytes = Value(sizeBytes),
        lastAccessedUtc = Value(lastAccessedUtc);
  static Insertable<ForecastCacheRow> custom({
    Expression<String>? cacheKey,
    Expression<String>? zoneId,
    Expression<String>? dayBucket,
    Expression<String>? forecastJson,
    Expression<int>? fetchedAtUtc,
    Expression<int>? validUntilUtc,
    Expression<int>? sizeBytes,
    Expression<int>? lastAccessedUtc,
    Expression<bool>? pinned,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (cacheKey != null) 'cache_key': cacheKey,
      if (zoneId != null) 'zone_id': zoneId,
      if (dayBucket != null) 'day_bucket': dayBucket,
      if (forecastJson != null) 'forecast_json': forecastJson,
      if (fetchedAtUtc != null) 'fetched_at_utc': fetchedAtUtc,
      if (validUntilUtc != null) 'valid_until_utc': validUntilUtc,
      if (sizeBytes != null) 'size_bytes': sizeBytes,
      if (lastAccessedUtc != null) 'last_accessed_utc': lastAccessedUtc,
      if (pinned != null) 'pinned': pinned,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ForecastCacheCompanion copyWith(
      {Value<String>? cacheKey,
      Value<String>? zoneId,
      Value<String>? dayBucket,
      Value<String>? forecastJson,
      Value<int>? fetchedAtUtc,
      Value<int>? validUntilUtc,
      Value<int>? sizeBytes,
      Value<int>? lastAccessedUtc,
      Value<bool>? pinned,
      Value<int>? rowid}) {
    return ForecastCacheCompanion(
      cacheKey: cacheKey ?? this.cacheKey,
      zoneId: zoneId ?? this.zoneId,
      dayBucket: dayBucket ?? this.dayBucket,
      forecastJson: forecastJson ?? this.forecastJson,
      fetchedAtUtc: fetchedAtUtc ?? this.fetchedAtUtc,
      validUntilUtc: validUntilUtc ?? this.validUntilUtc,
      sizeBytes: sizeBytes ?? this.sizeBytes,
      lastAccessedUtc: lastAccessedUtc ?? this.lastAccessedUtc,
      pinned: pinned ?? this.pinned,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (cacheKey.present) {
      map['cache_key'] = Variable<String>(cacheKey.value);
    }
    if (zoneId.present) {
      map['zone_id'] = Variable<String>(zoneId.value);
    }
    if (dayBucket.present) {
      map['day_bucket'] = Variable<String>(dayBucket.value);
    }
    if (forecastJson.present) {
      map['forecast_json'] = Variable<String>(forecastJson.value);
    }
    if (fetchedAtUtc.present) {
      map['fetched_at_utc'] = Variable<int>(fetchedAtUtc.value);
    }
    if (validUntilUtc.present) {
      map['valid_until_utc'] = Variable<int>(validUntilUtc.value);
    }
    if (sizeBytes.present) {
      map['size_bytes'] = Variable<int>(sizeBytes.value);
    }
    if (lastAccessedUtc.present) {
      map['last_accessed_utc'] = Variable<int>(lastAccessedUtc.value);
    }
    if (pinned.present) {
      map['pinned'] = Variable<bool>(pinned.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ForecastCacheCompanion(')
          ..write('cacheKey: $cacheKey, ')
          ..write('zoneId: $zoneId, ')
          ..write('dayBucket: $dayBucket, ')
          ..write('forecastJson: $forecastJson, ')
          ..write('fetchedAtUtc: $fetchedAtUtc, ')
          ..write('validUntilUtc: $validUntilUtc, ')
          ..write('sizeBytes: $sizeBytes, ')
          ..write('lastAccessedUtc: $lastAccessedUtc, ')
          ..write('pinned: $pinned, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TideCacheTable extends TideCache
    with TableInfo<$TideCacheTable, TideCacheRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TideCacheTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _cacheKeyMeta =
      const VerificationMeta('cacheKey');
  @override
  late final GeneratedColumn<String> cacheKey = GeneratedColumn<String>(
      'cache_key', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _stationIdMeta =
      const VerificationMeta('stationId');
  @override
  late final GeneratedColumn<String> stationId = GeneratedColumn<String>(
      'station_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dayBucketMeta =
      const VerificationMeta('dayBucket');
  @override
  late final GeneratedColumn<String> dayBucket = GeneratedColumn<String>(
      'day_bucket', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _predictionsJsonMeta =
      const VerificationMeta('predictionsJson');
  @override
  late final GeneratedColumn<String> predictionsJson = GeneratedColumn<String>(
      'predictions_json', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _fetchedAtUtcMeta =
      const VerificationMeta('fetchedAtUtc');
  @override
  late final GeneratedColumn<int> fetchedAtUtc = GeneratedColumn<int>(
      'fetched_at_utc', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _validUntilUtcMeta =
      const VerificationMeta('validUntilUtc');
  @override
  late final GeneratedColumn<int> validUntilUtc = GeneratedColumn<int>(
      'valid_until_utc', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _sizeBytesMeta =
      const VerificationMeta('sizeBytes');
  @override
  late final GeneratedColumn<int> sizeBytes = GeneratedColumn<int>(
      'size_bytes', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _lastAccessedUtcMeta =
      const VerificationMeta('lastAccessedUtc');
  @override
  late final GeneratedColumn<int> lastAccessedUtc = GeneratedColumn<int>(
      'last_accessed_utc', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _pinnedMeta = const VerificationMeta('pinned');
  @override
  late final GeneratedColumn<bool> pinned = GeneratedColumn<bool>(
      'pinned', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("pinned" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        cacheKey,
        stationId,
        dayBucket,
        predictionsJson,
        fetchedAtUtc,
        validUntilUtc,
        sizeBytes,
        lastAccessedUtc,
        pinned
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tide_cache';
  @override
  VerificationContext validateIntegrity(Insertable<TideCacheRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('cache_key')) {
      context.handle(_cacheKeyMeta,
          cacheKey.isAcceptableOrUnknown(data['cache_key']!, _cacheKeyMeta));
    } else if (isInserting) {
      context.missing(_cacheKeyMeta);
    }
    if (data.containsKey('station_id')) {
      context.handle(_stationIdMeta,
          stationId.isAcceptableOrUnknown(data['station_id']!, _stationIdMeta));
    } else if (isInserting) {
      context.missing(_stationIdMeta);
    }
    if (data.containsKey('day_bucket')) {
      context.handle(_dayBucketMeta,
          dayBucket.isAcceptableOrUnknown(data['day_bucket']!, _dayBucketMeta));
    } else if (isInserting) {
      context.missing(_dayBucketMeta);
    }
    if (data.containsKey('predictions_json')) {
      context.handle(
          _predictionsJsonMeta,
          predictionsJson.isAcceptableOrUnknown(
              data['predictions_json']!, _predictionsJsonMeta));
    } else if (isInserting) {
      context.missing(_predictionsJsonMeta);
    }
    if (data.containsKey('fetched_at_utc')) {
      context.handle(
          _fetchedAtUtcMeta,
          fetchedAtUtc.isAcceptableOrUnknown(
              data['fetched_at_utc']!, _fetchedAtUtcMeta));
    } else if (isInserting) {
      context.missing(_fetchedAtUtcMeta);
    }
    if (data.containsKey('valid_until_utc')) {
      context.handle(
          _validUntilUtcMeta,
          validUntilUtc.isAcceptableOrUnknown(
              data['valid_until_utc']!, _validUntilUtcMeta));
    } else if (isInserting) {
      context.missing(_validUntilUtcMeta);
    }
    if (data.containsKey('size_bytes')) {
      context.handle(_sizeBytesMeta,
          sizeBytes.isAcceptableOrUnknown(data['size_bytes']!, _sizeBytesMeta));
    } else if (isInserting) {
      context.missing(_sizeBytesMeta);
    }
    if (data.containsKey('last_accessed_utc')) {
      context.handle(
          _lastAccessedUtcMeta,
          lastAccessedUtc.isAcceptableOrUnknown(
              data['last_accessed_utc']!, _lastAccessedUtcMeta));
    } else if (isInserting) {
      context.missing(_lastAccessedUtcMeta);
    }
    if (data.containsKey('pinned')) {
      context.handle(_pinnedMeta,
          pinned.isAcceptableOrUnknown(data['pinned']!, _pinnedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {cacheKey};
  @override
  TideCacheRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TideCacheRow(
      cacheKey: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cache_key'])!,
      stationId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}station_id'])!,
      dayBucket: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}day_bucket'])!,
      predictionsJson: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}predictions_json'])!,
      fetchedAtUtc: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}fetched_at_utc'])!,
      validUntilUtc: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}valid_until_utc'])!,
      sizeBytes: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}size_bytes'])!,
      lastAccessedUtc: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}last_accessed_utc'])!,
      pinned: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}pinned'])!,
    );
  }

  @override
  $TideCacheTable createAlias(String alias) {
    return $TideCacheTable(attachedDatabase, alias);
  }
}

class TideCacheRow extends DataClass implements Insertable<TideCacheRow> {
  final String cacheKey;
  final String stationId;
  final String dayBucket;
  final String predictionsJson;
  final int fetchedAtUtc;
  final int validUntilUtc;
  final int sizeBytes;
  final int lastAccessedUtc;
  final bool pinned;
  const TideCacheRow(
      {required this.cacheKey,
      required this.stationId,
      required this.dayBucket,
      required this.predictionsJson,
      required this.fetchedAtUtc,
      required this.validUntilUtc,
      required this.sizeBytes,
      required this.lastAccessedUtc,
      required this.pinned});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['cache_key'] = Variable<String>(cacheKey);
    map['station_id'] = Variable<String>(stationId);
    map['day_bucket'] = Variable<String>(dayBucket);
    map['predictions_json'] = Variable<String>(predictionsJson);
    map['fetched_at_utc'] = Variable<int>(fetchedAtUtc);
    map['valid_until_utc'] = Variable<int>(validUntilUtc);
    map['size_bytes'] = Variable<int>(sizeBytes);
    map['last_accessed_utc'] = Variable<int>(lastAccessedUtc);
    map['pinned'] = Variable<bool>(pinned);
    return map;
  }

  TideCacheCompanion toCompanion(bool nullToAbsent) {
    return TideCacheCompanion(
      cacheKey: Value(cacheKey),
      stationId: Value(stationId),
      dayBucket: Value(dayBucket),
      predictionsJson: Value(predictionsJson),
      fetchedAtUtc: Value(fetchedAtUtc),
      validUntilUtc: Value(validUntilUtc),
      sizeBytes: Value(sizeBytes),
      lastAccessedUtc: Value(lastAccessedUtc),
      pinned: Value(pinned),
    );
  }

  factory TideCacheRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TideCacheRow(
      cacheKey: serializer.fromJson<String>(json['cacheKey']),
      stationId: serializer.fromJson<String>(json['stationId']),
      dayBucket: serializer.fromJson<String>(json['dayBucket']),
      predictionsJson: serializer.fromJson<String>(json['predictionsJson']),
      fetchedAtUtc: serializer.fromJson<int>(json['fetchedAtUtc']),
      validUntilUtc: serializer.fromJson<int>(json['validUntilUtc']),
      sizeBytes: serializer.fromJson<int>(json['sizeBytes']),
      lastAccessedUtc: serializer.fromJson<int>(json['lastAccessedUtc']),
      pinned: serializer.fromJson<bool>(json['pinned']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'cacheKey': serializer.toJson<String>(cacheKey),
      'stationId': serializer.toJson<String>(stationId),
      'dayBucket': serializer.toJson<String>(dayBucket),
      'predictionsJson': serializer.toJson<String>(predictionsJson),
      'fetchedAtUtc': serializer.toJson<int>(fetchedAtUtc),
      'validUntilUtc': serializer.toJson<int>(validUntilUtc),
      'sizeBytes': serializer.toJson<int>(sizeBytes),
      'lastAccessedUtc': serializer.toJson<int>(lastAccessedUtc),
      'pinned': serializer.toJson<bool>(pinned),
    };
  }

  TideCacheRow copyWith(
          {String? cacheKey,
          String? stationId,
          String? dayBucket,
          String? predictionsJson,
          int? fetchedAtUtc,
          int? validUntilUtc,
          int? sizeBytes,
          int? lastAccessedUtc,
          bool? pinned}) =>
      TideCacheRow(
        cacheKey: cacheKey ?? this.cacheKey,
        stationId: stationId ?? this.stationId,
        dayBucket: dayBucket ?? this.dayBucket,
        predictionsJson: predictionsJson ?? this.predictionsJson,
        fetchedAtUtc: fetchedAtUtc ?? this.fetchedAtUtc,
        validUntilUtc: validUntilUtc ?? this.validUntilUtc,
        sizeBytes: sizeBytes ?? this.sizeBytes,
        lastAccessedUtc: lastAccessedUtc ?? this.lastAccessedUtc,
        pinned: pinned ?? this.pinned,
      );
  TideCacheRow copyWithCompanion(TideCacheCompanion data) {
    return TideCacheRow(
      cacheKey: data.cacheKey.present ? data.cacheKey.value : this.cacheKey,
      stationId: data.stationId.present ? data.stationId.value : this.stationId,
      dayBucket: data.dayBucket.present ? data.dayBucket.value : this.dayBucket,
      predictionsJson: data.predictionsJson.present
          ? data.predictionsJson.value
          : this.predictionsJson,
      fetchedAtUtc: data.fetchedAtUtc.present
          ? data.fetchedAtUtc.value
          : this.fetchedAtUtc,
      validUntilUtc: data.validUntilUtc.present
          ? data.validUntilUtc.value
          : this.validUntilUtc,
      sizeBytes: data.sizeBytes.present ? data.sizeBytes.value : this.sizeBytes,
      lastAccessedUtc: data.lastAccessedUtc.present
          ? data.lastAccessedUtc.value
          : this.lastAccessedUtc,
      pinned: data.pinned.present ? data.pinned.value : this.pinned,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TideCacheRow(')
          ..write('cacheKey: $cacheKey, ')
          ..write('stationId: $stationId, ')
          ..write('dayBucket: $dayBucket, ')
          ..write('predictionsJson: $predictionsJson, ')
          ..write('fetchedAtUtc: $fetchedAtUtc, ')
          ..write('validUntilUtc: $validUntilUtc, ')
          ..write('sizeBytes: $sizeBytes, ')
          ..write('lastAccessedUtc: $lastAccessedUtc, ')
          ..write('pinned: $pinned')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      cacheKey,
      stationId,
      dayBucket,
      predictionsJson,
      fetchedAtUtc,
      validUntilUtc,
      sizeBytes,
      lastAccessedUtc,
      pinned);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TideCacheRow &&
          other.cacheKey == this.cacheKey &&
          other.stationId == this.stationId &&
          other.dayBucket == this.dayBucket &&
          other.predictionsJson == this.predictionsJson &&
          other.fetchedAtUtc == this.fetchedAtUtc &&
          other.validUntilUtc == this.validUntilUtc &&
          other.sizeBytes == this.sizeBytes &&
          other.lastAccessedUtc == this.lastAccessedUtc &&
          other.pinned == this.pinned);
}

class TideCacheCompanion extends UpdateCompanion<TideCacheRow> {
  final Value<String> cacheKey;
  final Value<String> stationId;
  final Value<String> dayBucket;
  final Value<String> predictionsJson;
  final Value<int> fetchedAtUtc;
  final Value<int> validUntilUtc;
  final Value<int> sizeBytes;
  final Value<int> lastAccessedUtc;
  final Value<bool> pinned;
  final Value<int> rowid;
  const TideCacheCompanion({
    this.cacheKey = const Value.absent(),
    this.stationId = const Value.absent(),
    this.dayBucket = const Value.absent(),
    this.predictionsJson = const Value.absent(),
    this.fetchedAtUtc = const Value.absent(),
    this.validUntilUtc = const Value.absent(),
    this.sizeBytes = const Value.absent(),
    this.lastAccessedUtc = const Value.absent(),
    this.pinned = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TideCacheCompanion.insert({
    required String cacheKey,
    required String stationId,
    required String dayBucket,
    required String predictionsJson,
    required int fetchedAtUtc,
    required int validUntilUtc,
    required int sizeBytes,
    required int lastAccessedUtc,
    this.pinned = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : cacheKey = Value(cacheKey),
        stationId = Value(stationId),
        dayBucket = Value(dayBucket),
        predictionsJson = Value(predictionsJson),
        fetchedAtUtc = Value(fetchedAtUtc),
        validUntilUtc = Value(validUntilUtc),
        sizeBytes = Value(sizeBytes),
        lastAccessedUtc = Value(lastAccessedUtc);
  static Insertable<TideCacheRow> custom({
    Expression<String>? cacheKey,
    Expression<String>? stationId,
    Expression<String>? dayBucket,
    Expression<String>? predictionsJson,
    Expression<int>? fetchedAtUtc,
    Expression<int>? validUntilUtc,
    Expression<int>? sizeBytes,
    Expression<int>? lastAccessedUtc,
    Expression<bool>? pinned,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (cacheKey != null) 'cache_key': cacheKey,
      if (stationId != null) 'station_id': stationId,
      if (dayBucket != null) 'day_bucket': dayBucket,
      if (predictionsJson != null) 'predictions_json': predictionsJson,
      if (fetchedAtUtc != null) 'fetched_at_utc': fetchedAtUtc,
      if (validUntilUtc != null) 'valid_until_utc': validUntilUtc,
      if (sizeBytes != null) 'size_bytes': sizeBytes,
      if (lastAccessedUtc != null) 'last_accessed_utc': lastAccessedUtc,
      if (pinned != null) 'pinned': pinned,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TideCacheCompanion copyWith(
      {Value<String>? cacheKey,
      Value<String>? stationId,
      Value<String>? dayBucket,
      Value<String>? predictionsJson,
      Value<int>? fetchedAtUtc,
      Value<int>? validUntilUtc,
      Value<int>? sizeBytes,
      Value<int>? lastAccessedUtc,
      Value<bool>? pinned,
      Value<int>? rowid}) {
    return TideCacheCompanion(
      cacheKey: cacheKey ?? this.cacheKey,
      stationId: stationId ?? this.stationId,
      dayBucket: dayBucket ?? this.dayBucket,
      predictionsJson: predictionsJson ?? this.predictionsJson,
      fetchedAtUtc: fetchedAtUtc ?? this.fetchedAtUtc,
      validUntilUtc: validUntilUtc ?? this.validUntilUtc,
      sizeBytes: sizeBytes ?? this.sizeBytes,
      lastAccessedUtc: lastAccessedUtc ?? this.lastAccessedUtc,
      pinned: pinned ?? this.pinned,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (cacheKey.present) {
      map['cache_key'] = Variable<String>(cacheKey.value);
    }
    if (stationId.present) {
      map['station_id'] = Variable<String>(stationId.value);
    }
    if (dayBucket.present) {
      map['day_bucket'] = Variable<String>(dayBucket.value);
    }
    if (predictionsJson.present) {
      map['predictions_json'] = Variable<String>(predictionsJson.value);
    }
    if (fetchedAtUtc.present) {
      map['fetched_at_utc'] = Variable<int>(fetchedAtUtc.value);
    }
    if (validUntilUtc.present) {
      map['valid_until_utc'] = Variable<int>(validUntilUtc.value);
    }
    if (sizeBytes.present) {
      map['size_bytes'] = Variable<int>(sizeBytes.value);
    }
    if (lastAccessedUtc.present) {
      map['last_accessed_utc'] = Variable<int>(lastAccessedUtc.value);
    }
    if (pinned.present) {
      map['pinned'] = Variable<bool>(pinned.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TideCacheCompanion(')
          ..write('cacheKey: $cacheKey, ')
          ..write('stationId: $stationId, ')
          ..write('dayBucket: $dayBucket, ')
          ..write('predictionsJson: $predictionsJson, ')
          ..write('fetchedAtUtc: $fetchedAtUtc, ')
          ..write('validUntilUtc: $validUntilUtc, ')
          ..write('sizeBytes: $sizeBytes, ')
          ..write('lastAccessedUtc: $lastAccessedUtc, ')
          ..write('pinned: $pinned, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CatchesTable catches = $CatchesTable(this);
  late final $TripPlansTable tripPlans = $TripPlansTable(this);
  late final $UserPreferencesTableTable userPreferencesTable =
      $UserPreferencesTableTable(this);
  late final $SyncQueueTable syncQueue = $SyncQueueTable(this);
  late final $ConditionsCacheTable conditionsCache =
      $ConditionsCacheTable(this);
  late final $ScoreCacheTable scoreCache = $ScoreCacheTable(this);
  late final $ChartTileCacheTable chartTileCache = $ChartTileCacheTable(this);
  late final $ForecastCacheTable forecastCache = $ForecastCacheTable(this);
  late final $TideCacheTable tideCache = $TideCacheTable(this);
  late final CatchesDao catchesDao = CatchesDao(this as AppDatabase);
  late final TripPlansDao tripPlansDao = TripPlansDao(this as AppDatabase);
  late final UserPreferencesDao userPreferencesDao =
      UserPreferencesDao(this as AppDatabase);
  late final SyncQueueDao syncQueueDao = SyncQueueDao(this as AppDatabase);
  late final ConditionsCacheDao conditionsCacheDao =
      ConditionsCacheDao(this as AppDatabase);
  late final ScoreCacheDao scoreCacheDao = ScoreCacheDao(this as AppDatabase);
  late final ChartTileCacheDao chartTileCacheDao =
      ChartTileCacheDao(this as AppDatabase);
  late final ForecastCacheDao forecastCacheDao =
      ForecastCacheDao(this as AppDatabase);
  late final TideCacheDao tideCacheDao = TideCacheDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        catches,
        tripPlans,
        userPreferencesTable,
        syncQueue,
        conditionsCache,
        scoreCache,
        chartTileCache,
        forecastCache,
        tideCache
      ];
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
typedef $$TripPlansTableCreateCompanionBuilder = TripPlansCompanion Function({
  required String id,
  Value<String?> userId,
  required String name,
  required double boundsSwLat,
  required double boundsSwLon,
  required double boundsNeLat,
  required double boundsNeLon,
  required int plannedStartUtc,
  required int plannedEndUtc,
  required String targetSpeciesId,
  required String cacheStatusJson,
  required int createdAtUtc,
  Value<int> rowid,
});
typedef $$TripPlansTableUpdateCompanionBuilder = TripPlansCompanion Function({
  Value<String> id,
  Value<String?> userId,
  Value<String> name,
  Value<double> boundsSwLat,
  Value<double> boundsSwLon,
  Value<double> boundsNeLat,
  Value<double> boundsNeLon,
  Value<int> plannedStartUtc,
  Value<int> plannedEndUtc,
  Value<String> targetSpeciesId,
  Value<String> cacheStatusJson,
  Value<int> createdAtUtc,
  Value<int> rowid,
});

class $$TripPlansTableFilterComposer
    extends Composer<_$AppDatabase, $TripPlansTable> {
  $$TripPlansTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get boundsSwLat => $composableBuilder(
      column: $table.boundsSwLat, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get boundsSwLon => $composableBuilder(
      column: $table.boundsSwLon, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get boundsNeLat => $composableBuilder(
      column: $table.boundsNeLat, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get boundsNeLon => $composableBuilder(
      column: $table.boundsNeLon, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get plannedStartUtc => $composableBuilder(
      column: $table.plannedStartUtc,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get plannedEndUtc => $composableBuilder(
      column: $table.plannedEndUtc, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get targetSpeciesId => $composableBuilder(
      column: $table.targetSpeciesId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get cacheStatusJson => $composableBuilder(
      column: $table.cacheStatusJson,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get createdAtUtc => $composableBuilder(
      column: $table.createdAtUtc, builder: (column) => ColumnFilters(column));
}

class $$TripPlansTableOrderingComposer
    extends Composer<_$AppDatabase, $TripPlansTable> {
  $$TripPlansTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get boundsSwLat => $composableBuilder(
      column: $table.boundsSwLat, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get boundsSwLon => $composableBuilder(
      column: $table.boundsSwLon, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get boundsNeLat => $composableBuilder(
      column: $table.boundsNeLat, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get boundsNeLon => $composableBuilder(
      column: $table.boundsNeLon, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get plannedStartUtc => $composableBuilder(
      column: $table.plannedStartUtc,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get plannedEndUtc => $composableBuilder(
      column: $table.plannedEndUtc,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get targetSpeciesId => $composableBuilder(
      column: $table.targetSpeciesId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get cacheStatusJson => $composableBuilder(
      column: $table.cacheStatusJson,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get createdAtUtc => $composableBuilder(
      column: $table.createdAtUtc,
      builder: (column) => ColumnOrderings(column));
}

class $$TripPlansTableAnnotationComposer
    extends Composer<_$AppDatabase, $TripPlansTable> {
  $$TripPlansTableAnnotationComposer({
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

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<double> get boundsSwLat => $composableBuilder(
      column: $table.boundsSwLat, builder: (column) => column);

  GeneratedColumn<double> get boundsSwLon => $composableBuilder(
      column: $table.boundsSwLon, builder: (column) => column);

  GeneratedColumn<double> get boundsNeLat => $composableBuilder(
      column: $table.boundsNeLat, builder: (column) => column);

  GeneratedColumn<double> get boundsNeLon => $composableBuilder(
      column: $table.boundsNeLon, builder: (column) => column);

  GeneratedColumn<int> get plannedStartUtc => $composableBuilder(
      column: $table.plannedStartUtc, builder: (column) => column);

  GeneratedColumn<int> get plannedEndUtc => $composableBuilder(
      column: $table.plannedEndUtc, builder: (column) => column);

  GeneratedColumn<String> get targetSpeciesId => $composableBuilder(
      column: $table.targetSpeciesId, builder: (column) => column);

  GeneratedColumn<String> get cacheStatusJson => $composableBuilder(
      column: $table.cacheStatusJson, builder: (column) => column);

  GeneratedColumn<int> get createdAtUtc => $composableBuilder(
      column: $table.createdAtUtc, builder: (column) => column);
}

class $$TripPlansTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TripPlansTable,
    TripPlanRow,
    $$TripPlansTableFilterComposer,
    $$TripPlansTableOrderingComposer,
    $$TripPlansTableAnnotationComposer,
    $$TripPlansTableCreateCompanionBuilder,
    $$TripPlansTableUpdateCompanionBuilder,
    (TripPlanRow, BaseReferences<_$AppDatabase, $TripPlansTable, TripPlanRow>),
    TripPlanRow,
    PrefetchHooks Function()> {
  $$TripPlansTableTableManager(_$AppDatabase db, $TripPlansTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TripPlansTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TripPlansTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TripPlansTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String?> userId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<double> boundsSwLat = const Value.absent(),
            Value<double> boundsSwLon = const Value.absent(),
            Value<double> boundsNeLat = const Value.absent(),
            Value<double> boundsNeLon = const Value.absent(),
            Value<int> plannedStartUtc = const Value.absent(),
            Value<int> plannedEndUtc = const Value.absent(),
            Value<String> targetSpeciesId = const Value.absent(),
            Value<String> cacheStatusJson = const Value.absent(),
            Value<int> createdAtUtc = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TripPlansCompanion(
            id: id,
            userId: userId,
            name: name,
            boundsSwLat: boundsSwLat,
            boundsSwLon: boundsSwLon,
            boundsNeLat: boundsNeLat,
            boundsNeLon: boundsNeLon,
            plannedStartUtc: plannedStartUtc,
            plannedEndUtc: plannedEndUtc,
            targetSpeciesId: targetSpeciesId,
            cacheStatusJson: cacheStatusJson,
            createdAtUtc: createdAtUtc,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            Value<String?> userId = const Value.absent(),
            required String name,
            required double boundsSwLat,
            required double boundsSwLon,
            required double boundsNeLat,
            required double boundsNeLon,
            required int plannedStartUtc,
            required int plannedEndUtc,
            required String targetSpeciesId,
            required String cacheStatusJson,
            required int createdAtUtc,
            Value<int> rowid = const Value.absent(),
          }) =>
              TripPlansCompanion.insert(
            id: id,
            userId: userId,
            name: name,
            boundsSwLat: boundsSwLat,
            boundsSwLon: boundsSwLon,
            boundsNeLat: boundsNeLat,
            boundsNeLon: boundsNeLon,
            plannedStartUtc: plannedStartUtc,
            plannedEndUtc: plannedEndUtc,
            targetSpeciesId: targetSpeciesId,
            cacheStatusJson: cacheStatusJson,
            createdAtUtc: createdAtUtc,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$TripPlansTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TripPlansTable,
    TripPlanRow,
    $$TripPlansTableFilterComposer,
    $$TripPlansTableOrderingComposer,
    $$TripPlansTableAnnotationComposer,
    $$TripPlansTableCreateCompanionBuilder,
    $$TripPlansTableUpdateCompanionBuilder,
    (TripPlanRow, BaseReferences<_$AppDatabase, $TripPlansTable, TripPlanRow>),
    TripPlanRow,
    PrefetchHooks Function()>;
typedef $$UserPreferencesTableTableCreateCompanionBuilder
    = UserPreferencesTableCompanion Function({
  Value<int> id,
  Value<String?> homeRegionId,
  Value<String?> primarySpeciesId,
  Value<String> units,
  Value<bool> privacyOptInAggregate,
  Value<int> cacheBudgetMb,
  Value<bool> useNmea2000WhenAvailable,
  Value<String?> gatewayConfigJson,
  required int updatedAtUtc,
});
typedef $$UserPreferencesTableTableUpdateCompanionBuilder
    = UserPreferencesTableCompanion Function({
  Value<int> id,
  Value<String?> homeRegionId,
  Value<String?> primarySpeciesId,
  Value<String> units,
  Value<bool> privacyOptInAggregate,
  Value<int> cacheBudgetMb,
  Value<bool> useNmea2000WhenAvailable,
  Value<String?> gatewayConfigJson,
  Value<int> updatedAtUtc,
});

class $$UserPreferencesTableTableFilterComposer
    extends Composer<_$AppDatabase, $UserPreferencesTableTable> {
  $$UserPreferencesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get homeRegionId => $composableBuilder(
      column: $table.homeRegionId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get primarySpeciesId => $composableBuilder(
      column: $table.primarySpeciesId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get units => $composableBuilder(
      column: $table.units, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get privacyOptInAggregate => $composableBuilder(
      column: $table.privacyOptInAggregate,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get cacheBudgetMb => $composableBuilder(
      column: $table.cacheBudgetMb, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get useNmea2000WhenAvailable => $composableBuilder(
      column: $table.useNmea2000WhenAvailable,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get gatewayConfigJson => $composableBuilder(
      column: $table.gatewayConfigJson,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get updatedAtUtc => $composableBuilder(
      column: $table.updatedAtUtc, builder: (column) => ColumnFilters(column));
}

class $$UserPreferencesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $UserPreferencesTableTable> {
  $$UserPreferencesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get homeRegionId => $composableBuilder(
      column: $table.homeRegionId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get primarySpeciesId => $composableBuilder(
      column: $table.primarySpeciesId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get units => $composableBuilder(
      column: $table.units, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get privacyOptInAggregate => $composableBuilder(
      column: $table.privacyOptInAggregate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get cacheBudgetMb => $composableBuilder(
      column: $table.cacheBudgetMb,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get useNmea2000WhenAvailable => $composableBuilder(
      column: $table.useNmea2000WhenAvailable,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get gatewayConfigJson => $composableBuilder(
      column: $table.gatewayConfigJson,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get updatedAtUtc => $composableBuilder(
      column: $table.updatedAtUtc,
      builder: (column) => ColumnOrderings(column));
}

class $$UserPreferencesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserPreferencesTableTable> {
  $$UserPreferencesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get homeRegionId => $composableBuilder(
      column: $table.homeRegionId, builder: (column) => column);

  GeneratedColumn<String> get primarySpeciesId => $composableBuilder(
      column: $table.primarySpeciesId, builder: (column) => column);

  GeneratedColumn<String> get units =>
      $composableBuilder(column: $table.units, builder: (column) => column);

  GeneratedColumn<bool> get privacyOptInAggregate => $composableBuilder(
      column: $table.privacyOptInAggregate, builder: (column) => column);

  GeneratedColumn<int> get cacheBudgetMb => $composableBuilder(
      column: $table.cacheBudgetMb, builder: (column) => column);

  GeneratedColumn<bool> get useNmea2000WhenAvailable => $composableBuilder(
      column: $table.useNmea2000WhenAvailable, builder: (column) => column);

  GeneratedColumn<String> get gatewayConfigJson => $composableBuilder(
      column: $table.gatewayConfigJson, builder: (column) => column);

  GeneratedColumn<int> get updatedAtUtc => $composableBuilder(
      column: $table.updatedAtUtc, builder: (column) => column);
}

class $$UserPreferencesTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UserPreferencesTableTable,
    UserPreferencesRow,
    $$UserPreferencesTableTableFilterComposer,
    $$UserPreferencesTableTableOrderingComposer,
    $$UserPreferencesTableTableAnnotationComposer,
    $$UserPreferencesTableTableCreateCompanionBuilder,
    $$UserPreferencesTableTableUpdateCompanionBuilder,
    (
      UserPreferencesRow,
      BaseReferences<_$AppDatabase, $UserPreferencesTableTable,
          UserPreferencesRow>
    ),
    UserPreferencesRow,
    PrefetchHooks Function()> {
  $$UserPreferencesTableTableTableManager(
      _$AppDatabase db, $UserPreferencesTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserPreferencesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserPreferencesTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserPreferencesTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> homeRegionId = const Value.absent(),
            Value<String?> primarySpeciesId = const Value.absent(),
            Value<String> units = const Value.absent(),
            Value<bool> privacyOptInAggregate = const Value.absent(),
            Value<int> cacheBudgetMb = const Value.absent(),
            Value<bool> useNmea2000WhenAvailable = const Value.absent(),
            Value<String?> gatewayConfigJson = const Value.absent(),
            Value<int> updatedAtUtc = const Value.absent(),
          }) =>
              UserPreferencesTableCompanion(
            id: id,
            homeRegionId: homeRegionId,
            primarySpeciesId: primarySpeciesId,
            units: units,
            privacyOptInAggregate: privacyOptInAggregate,
            cacheBudgetMb: cacheBudgetMb,
            useNmea2000WhenAvailable: useNmea2000WhenAvailable,
            gatewayConfigJson: gatewayConfigJson,
            updatedAtUtc: updatedAtUtc,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> homeRegionId = const Value.absent(),
            Value<String?> primarySpeciesId = const Value.absent(),
            Value<String> units = const Value.absent(),
            Value<bool> privacyOptInAggregate = const Value.absent(),
            Value<int> cacheBudgetMb = const Value.absent(),
            Value<bool> useNmea2000WhenAvailable = const Value.absent(),
            Value<String?> gatewayConfigJson = const Value.absent(),
            required int updatedAtUtc,
          }) =>
              UserPreferencesTableCompanion.insert(
            id: id,
            homeRegionId: homeRegionId,
            primarySpeciesId: primarySpeciesId,
            units: units,
            privacyOptInAggregate: privacyOptInAggregate,
            cacheBudgetMb: cacheBudgetMb,
            useNmea2000WhenAvailable: useNmea2000WhenAvailable,
            gatewayConfigJson: gatewayConfigJson,
            updatedAtUtc: updatedAtUtc,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$UserPreferencesTableTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $UserPreferencesTableTable,
        UserPreferencesRow,
        $$UserPreferencesTableTableFilterComposer,
        $$UserPreferencesTableTableOrderingComposer,
        $$UserPreferencesTableTableAnnotationComposer,
        $$UserPreferencesTableTableCreateCompanionBuilder,
        $$UserPreferencesTableTableUpdateCompanionBuilder,
        (
          UserPreferencesRow,
          BaseReferences<_$AppDatabase, $UserPreferencesTableTable,
              UserPreferencesRow>
        ),
        UserPreferencesRow,
        PrefetchHooks Function()>;
typedef $$SyncQueueTableCreateCompanionBuilder = SyncQueueCompanion Function({
  Value<int> id,
  required String targetTable,
  required String recordId,
  required String operation,
  required String payloadJson,
  required int enqueuedAtUtc,
  Value<int> attemptCount,
  Value<String?> lastError,
});
typedef $$SyncQueueTableUpdateCompanionBuilder = SyncQueueCompanion Function({
  Value<int> id,
  Value<String> targetTable,
  Value<String> recordId,
  Value<String> operation,
  Value<String> payloadJson,
  Value<int> enqueuedAtUtc,
  Value<int> attemptCount,
  Value<String?> lastError,
});

class $$SyncQueueTableFilterComposer
    extends Composer<_$AppDatabase, $SyncQueueTable> {
  $$SyncQueueTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get targetTable => $composableBuilder(
      column: $table.targetTable, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get recordId => $composableBuilder(
      column: $table.recordId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get operation => $composableBuilder(
      column: $table.operation, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get payloadJson => $composableBuilder(
      column: $table.payloadJson, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get enqueuedAtUtc => $composableBuilder(
      column: $table.enqueuedAtUtc, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get attemptCount => $composableBuilder(
      column: $table.attemptCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get lastError => $composableBuilder(
      column: $table.lastError, builder: (column) => ColumnFilters(column));
}

class $$SyncQueueTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncQueueTable> {
  $$SyncQueueTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get targetTable => $composableBuilder(
      column: $table.targetTable, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get recordId => $composableBuilder(
      column: $table.recordId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get operation => $composableBuilder(
      column: $table.operation, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get payloadJson => $composableBuilder(
      column: $table.payloadJson, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get enqueuedAtUtc => $composableBuilder(
      column: $table.enqueuedAtUtc,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get attemptCount => $composableBuilder(
      column: $table.attemptCount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get lastError => $composableBuilder(
      column: $table.lastError, builder: (column) => ColumnOrderings(column));
}

class $$SyncQueueTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncQueueTable> {
  $$SyncQueueTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get targetTable => $composableBuilder(
      column: $table.targetTable, builder: (column) => column);

  GeneratedColumn<String> get recordId =>
      $composableBuilder(column: $table.recordId, builder: (column) => column);

  GeneratedColumn<String> get operation =>
      $composableBuilder(column: $table.operation, builder: (column) => column);

  GeneratedColumn<String> get payloadJson => $composableBuilder(
      column: $table.payloadJson, builder: (column) => column);

  GeneratedColumn<int> get enqueuedAtUtc => $composableBuilder(
      column: $table.enqueuedAtUtc, builder: (column) => column);

  GeneratedColumn<int> get attemptCount => $composableBuilder(
      column: $table.attemptCount, builder: (column) => column);

  GeneratedColumn<String> get lastError =>
      $composableBuilder(column: $table.lastError, builder: (column) => column);
}

class $$SyncQueueTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SyncQueueTable,
    SyncQueueEntry,
    $$SyncQueueTableFilterComposer,
    $$SyncQueueTableOrderingComposer,
    $$SyncQueueTableAnnotationComposer,
    $$SyncQueueTableCreateCompanionBuilder,
    $$SyncQueueTableUpdateCompanionBuilder,
    (
      SyncQueueEntry,
      BaseReferences<_$AppDatabase, $SyncQueueTable, SyncQueueEntry>
    ),
    SyncQueueEntry,
    PrefetchHooks Function()> {
  $$SyncQueueTableTableManager(_$AppDatabase db, $SyncQueueTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncQueueTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncQueueTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncQueueTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> targetTable = const Value.absent(),
            Value<String> recordId = const Value.absent(),
            Value<String> operation = const Value.absent(),
            Value<String> payloadJson = const Value.absent(),
            Value<int> enqueuedAtUtc = const Value.absent(),
            Value<int> attemptCount = const Value.absent(),
            Value<String?> lastError = const Value.absent(),
          }) =>
              SyncQueueCompanion(
            id: id,
            targetTable: targetTable,
            recordId: recordId,
            operation: operation,
            payloadJson: payloadJson,
            enqueuedAtUtc: enqueuedAtUtc,
            attemptCount: attemptCount,
            lastError: lastError,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String targetTable,
            required String recordId,
            required String operation,
            required String payloadJson,
            required int enqueuedAtUtc,
            Value<int> attemptCount = const Value.absent(),
            Value<String?> lastError = const Value.absent(),
          }) =>
              SyncQueueCompanion.insert(
            id: id,
            targetTable: targetTable,
            recordId: recordId,
            operation: operation,
            payloadJson: payloadJson,
            enqueuedAtUtc: enqueuedAtUtc,
            attemptCount: attemptCount,
            lastError: lastError,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SyncQueueTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SyncQueueTable,
    SyncQueueEntry,
    $$SyncQueueTableFilterComposer,
    $$SyncQueueTableOrderingComposer,
    $$SyncQueueTableAnnotationComposer,
    $$SyncQueueTableCreateCompanionBuilder,
    $$SyncQueueTableUpdateCompanionBuilder,
    (
      SyncQueueEntry,
      BaseReferences<_$AppDatabase, $SyncQueueTable, SyncQueueEntry>
    ),
    SyncQueueEntry,
    PrefetchHooks Function()>;
typedef $$ConditionsCacheTableCreateCompanionBuilder = ConditionsCacheCompanion
    Function({
  required String cacheKey,
  required String dataType,
  required String source,
  required String valueJson,
  required int fetchedAtUtc,
  required int validUntilUtc,
  required int sizeBytes,
  required int lastAccessedUtc,
  Value<int> rowid,
});
typedef $$ConditionsCacheTableUpdateCompanionBuilder = ConditionsCacheCompanion
    Function({
  Value<String> cacheKey,
  Value<String> dataType,
  Value<String> source,
  Value<String> valueJson,
  Value<int> fetchedAtUtc,
  Value<int> validUntilUtc,
  Value<int> sizeBytes,
  Value<int> lastAccessedUtc,
  Value<int> rowid,
});

class $$ConditionsCacheTableFilterComposer
    extends Composer<_$AppDatabase, $ConditionsCacheTable> {
  $$ConditionsCacheTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get cacheKey => $composableBuilder(
      column: $table.cacheKey, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get dataType => $composableBuilder(
      column: $table.dataType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get source => $composableBuilder(
      column: $table.source, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get valueJson => $composableBuilder(
      column: $table.valueJson, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get fetchedAtUtc => $composableBuilder(
      column: $table.fetchedAtUtc, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get validUntilUtc => $composableBuilder(
      column: $table.validUntilUtc, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sizeBytes => $composableBuilder(
      column: $table.sizeBytes, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get lastAccessedUtc => $composableBuilder(
      column: $table.lastAccessedUtc,
      builder: (column) => ColumnFilters(column));
}

class $$ConditionsCacheTableOrderingComposer
    extends Composer<_$AppDatabase, $ConditionsCacheTable> {
  $$ConditionsCacheTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get cacheKey => $composableBuilder(
      column: $table.cacheKey, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get dataType => $composableBuilder(
      column: $table.dataType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get source => $composableBuilder(
      column: $table.source, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get valueJson => $composableBuilder(
      column: $table.valueJson, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get fetchedAtUtc => $composableBuilder(
      column: $table.fetchedAtUtc,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get validUntilUtc => $composableBuilder(
      column: $table.validUntilUtc,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sizeBytes => $composableBuilder(
      column: $table.sizeBytes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get lastAccessedUtc => $composableBuilder(
      column: $table.lastAccessedUtc,
      builder: (column) => ColumnOrderings(column));
}

class $$ConditionsCacheTableAnnotationComposer
    extends Composer<_$AppDatabase, $ConditionsCacheTable> {
  $$ConditionsCacheTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get cacheKey =>
      $composableBuilder(column: $table.cacheKey, builder: (column) => column);

  GeneratedColumn<String> get dataType =>
      $composableBuilder(column: $table.dataType, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<String> get valueJson =>
      $composableBuilder(column: $table.valueJson, builder: (column) => column);

  GeneratedColumn<int> get fetchedAtUtc => $composableBuilder(
      column: $table.fetchedAtUtc, builder: (column) => column);

  GeneratedColumn<int> get validUntilUtc => $composableBuilder(
      column: $table.validUntilUtc, builder: (column) => column);

  GeneratedColumn<int> get sizeBytes =>
      $composableBuilder(column: $table.sizeBytes, builder: (column) => column);

  GeneratedColumn<int> get lastAccessedUtc => $composableBuilder(
      column: $table.lastAccessedUtc, builder: (column) => column);
}

class $$ConditionsCacheTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ConditionsCacheTable,
    ConditionsCacheRow,
    $$ConditionsCacheTableFilterComposer,
    $$ConditionsCacheTableOrderingComposer,
    $$ConditionsCacheTableAnnotationComposer,
    $$ConditionsCacheTableCreateCompanionBuilder,
    $$ConditionsCacheTableUpdateCompanionBuilder,
    (
      ConditionsCacheRow,
      BaseReferences<_$AppDatabase, $ConditionsCacheTable, ConditionsCacheRow>
    ),
    ConditionsCacheRow,
    PrefetchHooks Function()> {
  $$ConditionsCacheTableTableManager(
      _$AppDatabase db, $ConditionsCacheTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ConditionsCacheTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ConditionsCacheTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ConditionsCacheTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> cacheKey = const Value.absent(),
            Value<String> dataType = const Value.absent(),
            Value<String> source = const Value.absent(),
            Value<String> valueJson = const Value.absent(),
            Value<int> fetchedAtUtc = const Value.absent(),
            Value<int> validUntilUtc = const Value.absent(),
            Value<int> sizeBytes = const Value.absent(),
            Value<int> lastAccessedUtc = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ConditionsCacheCompanion(
            cacheKey: cacheKey,
            dataType: dataType,
            source: source,
            valueJson: valueJson,
            fetchedAtUtc: fetchedAtUtc,
            validUntilUtc: validUntilUtc,
            sizeBytes: sizeBytes,
            lastAccessedUtc: lastAccessedUtc,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String cacheKey,
            required String dataType,
            required String source,
            required String valueJson,
            required int fetchedAtUtc,
            required int validUntilUtc,
            required int sizeBytes,
            required int lastAccessedUtc,
            Value<int> rowid = const Value.absent(),
          }) =>
              ConditionsCacheCompanion.insert(
            cacheKey: cacheKey,
            dataType: dataType,
            source: source,
            valueJson: valueJson,
            fetchedAtUtc: fetchedAtUtc,
            validUntilUtc: validUntilUtc,
            sizeBytes: sizeBytes,
            lastAccessedUtc: lastAccessedUtc,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ConditionsCacheTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ConditionsCacheTable,
    ConditionsCacheRow,
    $$ConditionsCacheTableFilterComposer,
    $$ConditionsCacheTableOrderingComposer,
    $$ConditionsCacheTableAnnotationComposer,
    $$ConditionsCacheTableCreateCompanionBuilder,
    $$ConditionsCacheTableUpdateCompanionBuilder,
    (
      ConditionsCacheRow,
      BaseReferences<_$AppDatabase, $ConditionsCacheTable, ConditionsCacheRow>
    ),
    ConditionsCacheRow,
    PrefetchHooks Function()>;
typedef $$ScoreCacheTableCreateCompanionBuilder = ScoreCacheCompanion Function({
  required String cacheKey,
  required String speciesId,
  required double cellLat,
  required double cellLon,
  required String conditionsHash,
  required double score,
  required String reasoningJson,
  required int computedAtUtc,
  required int validUntilUtc,
  required int lastAccessedUtc,
  Value<int> rowid,
});
typedef $$ScoreCacheTableUpdateCompanionBuilder = ScoreCacheCompanion Function({
  Value<String> cacheKey,
  Value<String> speciesId,
  Value<double> cellLat,
  Value<double> cellLon,
  Value<String> conditionsHash,
  Value<double> score,
  Value<String> reasoningJson,
  Value<int> computedAtUtc,
  Value<int> validUntilUtc,
  Value<int> lastAccessedUtc,
  Value<int> rowid,
});

class $$ScoreCacheTableFilterComposer
    extends Composer<_$AppDatabase, $ScoreCacheTable> {
  $$ScoreCacheTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get cacheKey => $composableBuilder(
      column: $table.cacheKey, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get speciesId => $composableBuilder(
      column: $table.speciesId, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get cellLat => $composableBuilder(
      column: $table.cellLat, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get cellLon => $composableBuilder(
      column: $table.cellLon, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get conditionsHash => $composableBuilder(
      column: $table.conditionsHash,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get score => $composableBuilder(
      column: $table.score, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get reasoningJson => $composableBuilder(
      column: $table.reasoningJson, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get computedAtUtc => $composableBuilder(
      column: $table.computedAtUtc, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get validUntilUtc => $composableBuilder(
      column: $table.validUntilUtc, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get lastAccessedUtc => $composableBuilder(
      column: $table.lastAccessedUtc,
      builder: (column) => ColumnFilters(column));
}

class $$ScoreCacheTableOrderingComposer
    extends Composer<_$AppDatabase, $ScoreCacheTable> {
  $$ScoreCacheTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get cacheKey => $composableBuilder(
      column: $table.cacheKey, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get speciesId => $composableBuilder(
      column: $table.speciesId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get cellLat => $composableBuilder(
      column: $table.cellLat, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get cellLon => $composableBuilder(
      column: $table.cellLon, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get conditionsHash => $composableBuilder(
      column: $table.conditionsHash,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get score => $composableBuilder(
      column: $table.score, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get reasoningJson => $composableBuilder(
      column: $table.reasoningJson,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get computedAtUtc => $composableBuilder(
      column: $table.computedAtUtc,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get validUntilUtc => $composableBuilder(
      column: $table.validUntilUtc,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get lastAccessedUtc => $composableBuilder(
      column: $table.lastAccessedUtc,
      builder: (column) => ColumnOrderings(column));
}

class $$ScoreCacheTableAnnotationComposer
    extends Composer<_$AppDatabase, $ScoreCacheTable> {
  $$ScoreCacheTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get cacheKey =>
      $composableBuilder(column: $table.cacheKey, builder: (column) => column);

  GeneratedColumn<String> get speciesId =>
      $composableBuilder(column: $table.speciesId, builder: (column) => column);

  GeneratedColumn<double> get cellLat =>
      $composableBuilder(column: $table.cellLat, builder: (column) => column);

  GeneratedColumn<double> get cellLon =>
      $composableBuilder(column: $table.cellLon, builder: (column) => column);

  GeneratedColumn<String> get conditionsHash => $composableBuilder(
      column: $table.conditionsHash, builder: (column) => column);

  GeneratedColumn<double> get score =>
      $composableBuilder(column: $table.score, builder: (column) => column);

  GeneratedColumn<String> get reasoningJson => $composableBuilder(
      column: $table.reasoningJson, builder: (column) => column);

  GeneratedColumn<int> get computedAtUtc => $composableBuilder(
      column: $table.computedAtUtc, builder: (column) => column);

  GeneratedColumn<int> get validUntilUtc => $composableBuilder(
      column: $table.validUntilUtc, builder: (column) => column);

  GeneratedColumn<int> get lastAccessedUtc => $composableBuilder(
      column: $table.lastAccessedUtc, builder: (column) => column);
}

class $$ScoreCacheTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ScoreCacheTable,
    ScoreCacheRow,
    $$ScoreCacheTableFilterComposer,
    $$ScoreCacheTableOrderingComposer,
    $$ScoreCacheTableAnnotationComposer,
    $$ScoreCacheTableCreateCompanionBuilder,
    $$ScoreCacheTableUpdateCompanionBuilder,
    (
      ScoreCacheRow,
      BaseReferences<_$AppDatabase, $ScoreCacheTable, ScoreCacheRow>
    ),
    ScoreCacheRow,
    PrefetchHooks Function()> {
  $$ScoreCacheTableTableManager(_$AppDatabase db, $ScoreCacheTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ScoreCacheTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ScoreCacheTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ScoreCacheTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> cacheKey = const Value.absent(),
            Value<String> speciesId = const Value.absent(),
            Value<double> cellLat = const Value.absent(),
            Value<double> cellLon = const Value.absent(),
            Value<String> conditionsHash = const Value.absent(),
            Value<double> score = const Value.absent(),
            Value<String> reasoningJson = const Value.absent(),
            Value<int> computedAtUtc = const Value.absent(),
            Value<int> validUntilUtc = const Value.absent(),
            Value<int> lastAccessedUtc = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ScoreCacheCompanion(
            cacheKey: cacheKey,
            speciesId: speciesId,
            cellLat: cellLat,
            cellLon: cellLon,
            conditionsHash: conditionsHash,
            score: score,
            reasoningJson: reasoningJson,
            computedAtUtc: computedAtUtc,
            validUntilUtc: validUntilUtc,
            lastAccessedUtc: lastAccessedUtc,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String cacheKey,
            required String speciesId,
            required double cellLat,
            required double cellLon,
            required String conditionsHash,
            required double score,
            required String reasoningJson,
            required int computedAtUtc,
            required int validUntilUtc,
            required int lastAccessedUtc,
            Value<int> rowid = const Value.absent(),
          }) =>
              ScoreCacheCompanion.insert(
            cacheKey: cacheKey,
            speciesId: speciesId,
            cellLat: cellLat,
            cellLon: cellLon,
            conditionsHash: conditionsHash,
            score: score,
            reasoningJson: reasoningJson,
            computedAtUtc: computedAtUtc,
            validUntilUtc: validUntilUtc,
            lastAccessedUtc: lastAccessedUtc,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ScoreCacheTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ScoreCacheTable,
    ScoreCacheRow,
    $$ScoreCacheTableFilterComposer,
    $$ScoreCacheTableOrderingComposer,
    $$ScoreCacheTableAnnotationComposer,
    $$ScoreCacheTableCreateCompanionBuilder,
    $$ScoreCacheTableUpdateCompanionBuilder,
    (
      ScoreCacheRow,
      BaseReferences<_$AppDatabase, $ScoreCacheTable, ScoreCacheRow>
    ),
    ScoreCacheRow,
    PrefetchHooks Function()>;
typedef $$ChartTileCacheTableCreateCompanionBuilder = ChartTileCacheCompanion
    Function({
  required String cacheKey,
  required int zoom,
  required int x,
  required int y,
  required String chartRevision,
  required Uint8List tileBlob,
  required int sizeBytes,
  required int fetchedAtUtc,
  required int lastAccessedUtc,
  Value<bool> pinned,
  Value<int> rowid,
});
typedef $$ChartTileCacheTableUpdateCompanionBuilder = ChartTileCacheCompanion
    Function({
  Value<String> cacheKey,
  Value<int> zoom,
  Value<int> x,
  Value<int> y,
  Value<String> chartRevision,
  Value<Uint8List> tileBlob,
  Value<int> sizeBytes,
  Value<int> fetchedAtUtc,
  Value<int> lastAccessedUtc,
  Value<bool> pinned,
  Value<int> rowid,
});

class $$ChartTileCacheTableFilterComposer
    extends Composer<_$AppDatabase, $ChartTileCacheTable> {
  $$ChartTileCacheTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get cacheKey => $composableBuilder(
      column: $table.cacheKey, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get zoom => $composableBuilder(
      column: $table.zoom, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get x => $composableBuilder(
      column: $table.x, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get y => $composableBuilder(
      column: $table.y, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get chartRevision => $composableBuilder(
      column: $table.chartRevision, builder: (column) => ColumnFilters(column));

  ColumnFilters<Uint8List> get tileBlob => $composableBuilder(
      column: $table.tileBlob, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sizeBytes => $composableBuilder(
      column: $table.sizeBytes, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get fetchedAtUtc => $composableBuilder(
      column: $table.fetchedAtUtc, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get lastAccessedUtc => $composableBuilder(
      column: $table.lastAccessedUtc,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get pinned => $composableBuilder(
      column: $table.pinned, builder: (column) => ColumnFilters(column));
}

class $$ChartTileCacheTableOrderingComposer
    extends Composer<_$AppDatabase, $ChartTileCacheTable> {
  $$ChartTileCacheTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get cacheKey => $composableBuilder(
      column: $table.cacheKey, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get zoom => $composableBuilder(
      column: $table.zoom, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get x => $composableBuilder(
      column: $table.x, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get y => $composableBuilder(
      column: $table.y, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get chartRevision => $composableBuilder(
      column: $table.chartRevision,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<Uint8List> get tileBlob => $composableBuilder(
      column: $table.tileBlob, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sizeBytes => $composableBuilder(
      column: $table.sizeBytes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get fetchedAtUtc => $composableBuilder(
      column: $table.fetchedAtUtc,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get lastAccessedUtc => $composableBuilder(
      column: $table.lastAccessedUtc,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get pinned => $composableBuilder(
      column: $table.pinned, builder: (column) => ColumnOrderings(column));
}

class $$ChartTileCacheTableAnnotationComposer
    extends Composer<_$AppDatabase, $ChartTileCacheTable> {
  $$ChartTileCacheTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get cacheKey =>
      $composableBuilder(column: $table.cacheKey, builder: (column) => column);

  GeneratedColumn<int> get zoom =>
      $composableBuilder(column: $table.zoom, builder: (column) => column);

  GeneratedColumn<int> get x =>
      $composableBuilder(column: $table.x, builder: (column) => column);

  GeneratedColumn<int> get y =>
      $composableBuilder(column: $table.y, builder: (column) => column);

  GeneratedColumn<String> get chartRevision => $composableBuilder(
      column: $table.chartRevision, builder: (column) => column);

  GeneratedColumn<Uint8List> get tileBlob =>
      $composableBuilder(column: $table.tileBlob, builder: (column) => column);

  GeneratedColumn<int> get sizeBytes =>
      $composableBuilder(column: $table.sizeBytes, builder: (column) => column);

  GeneratedColumn<int> get fetchedAtUtc => $composableBuilder(
      column: $table.fetchedAtUtc, builder: (column) => column);

  GeneratedColumn<int> get lastAccessedUtc => $composableBuilder(
      column: $table.lastAccessedUtc, builder: (column) => column);

  GeneratedColumn<bool> get pinned =>
      $composableBuilder(column: $table.pinned, builder: (column) => column);
}

class $$ChartTileCacheTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ChartTileCacheTable,
    ChartTileCacheRow,
    $$ChartTileCacheTableFilterComposer,
    $$ChartTileCacheTableOrderingComposer,
    $$ChartTileCacheTableAnnotationComposer,
    $$ChartTileCacheTableCreateCompanionBuilder,
    $$ChartTileCacheTableUpdateCompanionBuilder,
    (
      ChartTileCacheRow,
      BaseReferences<_$AppDatabase, $ChartTileCacheTable, ChartTileCacheRow>
    ),
    ChartTileCacheRow,
    PrefetchHooks Function()> {
  $$ChartTileCacheTableTableManager(
      _$AppDatabase db, $ChartTileCacheTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ChartTileCacheTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ChartTileCacheTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ChartTileCacheTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> cacheKey = const Value.absent(),
            Value<int> zoom = const Value.absent(),
            Value<int> x = const Value.absent(),
            Value<int> y = const Value.absent(),
            Value<String> chartRevision = const Value.absent(),
            Value<Uint8List> tileBlob = const Value.absent(),
            Value<int> sizeBytes = const Value.absent(),
            Value<int> fetchedAtUtc = const Value.absent(),
            Value<int> lastAccessedUtc = const Value.absent(),
            Value<bool> pinned = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ChartTileCacheCompanion(
            cacheKey: cacheKey,
            zoom: zoom,
            x: x,
            y: y,
            chartRevision: chartRevision,
            tileBlob: tileBlob,
            sizeBytes: sizeBytes,
            fetchedAtUtc: fetchedAtUtc,
            lastAccessedUtc: lastAccessedUtc,
            pinned: pinned,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String cacheKey,
            required int zoom,
            required int x,
            required int y,
            required String chartRevision,
            required Uint8List tileBlob,
            required int sizeBytes,
            required int fetchedAtUtc,
            required int lastAccessedUtc,
            Value<bool> pinned = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ChartTileCacheCompanion.insert(
            cacheKey: cacheKey,
            zoom: zoom,
            x: x,
            y: y,
            chartRevision: chartRevision,
            tileBlob: tileBlob,
            sizeBytes: sizeBytes,
            fetchedAtUtc: fetchedAtUtc,
            lastAccessedUtc: lastAccessedUtc,
            pinned: pinned,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ChartTileCacheTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ChartTileCacheTable,
    ChartTileCacheRow,
    $$ChartTileCacheTableFilterComposer,
    $$ChartTileCacheTableOrderingComposer,
    $$ChartTileCacheTableAnnotationComposer,
    $$ChartTileCacheTableCreateCompanionBuilder,
    $$ChartTileCacheTableUpdateCompanionBuilder,
    (
      ChartTileCacheRow,
      BaseReferences<_$AppDatabase, $ChartTileCacheTable, ChartTileCacheRow>
    ),
    ChartTileCacheRow,
    PrefetchHooks Function()>;
typedef $$ForecastCacheTableCreateCompanionBuilder = ForecastCacheCompanion
    Function({
  required String cacheKey,
  required String zoneId,
  required String dayBucket,
  required String forecastJson,
  required int fetchedAtUtc,
  required int validUntilUtc,
  required int sizeBytes,
  required int lastAccessedUtc,
  Value<bool> pinned,
  Value<int> rowid,
});
typedef $$ForecastCacheTableUpdateCompanionBuilder = ForecastCacheCompanion
    Function({
  Value<String> cacheKey,
  Value<String> zoneId,
  Value<String> dayBucket,
  Value<String> forecastJson,
  Value<int> fetchedAtUtc,
  Value<int> validUntilUtc,
  Value<int> sizeBytes,
  Value<int> lastAccessedUtc,
  Value<bool> pinned,
  Value<int> rowid,
});

class $$ForecastCacheTableFilterComposer
    extends Composer<_$AppDatabase, $ForecastCacheTable> {
  $$ForecastCacheTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get cacheKey => $composableBuilder(
      column: $table.cacheKey, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get zoneId => $composableBuilder(
      column: $table.zoneId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get dayBucket => $composableBuilder(
      column: $table.dayBucket, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get forecastJson => $composableBuilder(
      column: $table.forecastJson, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get fetchedAtUtc => $composableBuilder(
      column: $table.fetchedAtUtc, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get validUntilUtc => $composableBuilder(
      column: $table.validUntilUtc, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sizeBytes => $composableBuilder(
      column: $table.sizeBytes, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get lastAccessedUtc => $composableBuilder(
      column: $table.lastAccessedUtc,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get pinned => $composableBuilder(
      column: $table.pinned, builder: (column) => ColumnFilters(column));
}

class $$ForecastCacheTableOrderingComposer
    extends Composer<_$AppDatabase, $ForecastCacheTable> {
  $$ForecastCacheTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get cacheKey => $composableBuilder(
      column: $table.cacheKey, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get zoneId => $composableBuilder(
      column: $table.zoneId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get dayBucket => $composableBuilder(
      column: $table.dayBucket, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get forecastJson => $composableBuilder(
      column: $table.forecastJson,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get fetchedAtUtc => $composableBuilder(
      column: $table.fetchedAtUtc,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get validUntilUtc => $composableBuilder(
      column: $table.validUntilUtc,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sizeBytes => $composableBuilder(
      column: $table.sizeBytes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get lastAccessedUtc => $composableBuilder(
      column: $table.lastAccessedUtc,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get pinned => $composableBuilder(
      column: $table.pinned, builder: (column) => ColumnOrderings(column));
}

class $$ForecastCacheTableAnnotationComposer
    extends Composer<_$AppDatabase, $ForecastCacheTable> {
  $$ForecastCacheTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get cacheKey =>
      $composableBuilder(column: $table.cacheKey, builder: (column) => column);

  GeneratedColumn<String> get zoneId =>
      $composableBuilder(column: $table.zoneId, builder: (column) => column);

  GeneratedColumn<String> get dayBucket =>
      $composableBuilder(column: $table.dayBucket, builder: (column) => column);

  GeneratedColumn<String> get forecastJson => $composableBuilder(
      column: $table.forecastJson, builder: (column) => column);

  GeneratedColumn<int> get fetchedAtUtc => $composableBuilder(
      column: $table.fetchedAtUtc, builder: (column) => column);

  GeneratedColumn<int> get validUntilUtc => $composableBuilder(
      column: $table.validUntilUtc, builder: (column) => column);

  GeneratedColumn<int> get sizeBytes =>
      $composableBuilder(column: $table.sizeBytes, builder: (column) => column);

  GeneratedColumn<int> get lastAccessedUtc => $composableBuilder(
      column: $table.lastAccessedUtc, builder: (column) => column);

  GeneratedColumn<bool> get pinned =>
      $composableBuilder(column: $table.pinned, builder: (column) => column);
}

class $$ForecastCacheTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ForecastCacheTable,
    ForecastCacheRow,
    $$ForecastCacheTableFilterComposer,
    $$ForecastCacheTableOrderingComposer,
    $$ForecastCacheTableAnnotationComposer,
    $$ForecastCacheTableCreateCompanionBuilder,
    $$ForecastCacheTableUpdateCompanionBuilder,
    (
      ForecastCacheRow,
      BaseReferences<_$AppDatabase, $ForecastCacheTable, ForecastCacheRow>
    ),
    ForecastCacheRow,
    PrefetchHooks Function()> {
  $$ForecastCacheTableTableManager(_$AppDatabase db, $ForecastCacheTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ForecastCacheTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ForecastCacheTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ForecastCacheTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> cacheKey = const Value.absent(),
            Value<String> zoneId = const Value.absent(),
            Value<String> dayBucket = const Value.absent(),
            Value<String> forecastJson = const Value.absent(),
            Value<int> fetchedAtUtc = const Value.absent(),
            Value<int> validUntilUtc = const Value.absent(),
            Value<int> sizeBytes = const Value.absent(),
            Value<int> lastAccessedUtc = const Value.absent(),
            Value<bool> pinned = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ForecastCacheCompanion(
            cacheKey: cacheKey,
            zoneId: zoneId,
            dayBucket: dayBucket,
            forecastJson: forecastJson,
            fetchedAtUtc: fetchedAtUtc,
            validUntilUtc: validUntilUtc,
            sizeBytes: sizeBytes,
            lastAccessedUtc: lastAccessedUtc,
            pinned: pinned,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String cacheKey,
            required String zoneId,
            required String dayBucket,
            required String forecastJson,
            required int fetchedAtUtc,
            required int validUntilUtc,
            required int sizeBytes,
            required int lastAccessedUtc,
            Value<bool> pinned = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ForecastCacheCompanion.insert(
            cacheKey: cacheKey,
            zoneId: zoneId,
            dayBucket: dayBucket,
            forecastJson: forecastJson,
            fetchedAtUtc: fetchedAtUtc,
            validUntilUtc: validUntilUtc,
            sizeBytes: sizeBytes,
            lastAccessedUtc: lastAccessedUtc,
            pinned: pinned,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ForecastCacheTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ForecastCacheTable,
    ForecastCacheRow,
    $$ForecastCacheTableFilterComposer,
    $$ForecastCacheTableOrderingComposer,
    $$ForecastCacheTableAnnotationComposer,
    $$ForecastCacheTableCreateCompanionBuilder,
    $$ForecastCacheTableUpdateCompanionBuilder,
    (
      ForecastCacheRow,
      BaseReferences<_$AppDatabase, $ForecastCacheTable, ForecastCacheRow>
    ),
    ForecastCacheRow,
    PrefetchHooks Function()>;
typedef $$TideCacheTableCreateCompanionBuilder = TideCacheCompanion Function({
  required String cacheKey,
  required String stationId,
  required String dayBucket,
  required String predictionsJson,
  required int fetchedAtUtc,
  required int validUntilUtc,
  required int sizeBytes,
  required int lastAccessedUtc,
  Value<bool> pinned,
  Value<int> rowid,
});
typedef $$TideCacheTableUpdateCompanionBuilder = TideCacheCompanion Function({
  Value<String> cacheKey,
  Value<String> stationId,
  Value<String> dayBucket,
  Value<String> predictionsJson,
  Value<int> fetchedAtUtc,
  Value<int> validUntilUtc,
  Value<int> sizeBytes,
  Value<int> lastAccessedUtc,
  Value<bool> pinned,
  Value<int> rowid,
});

class $$TideCacheTableFilterComposer
    extends Composer<_$AppDatabase, $TideCacheTable> {
  $$TideCacheTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get cacheKey => $composableBuilder(
      column: $table.cacheKey, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get stationId => $composableBuilder(
      column: $table.stationId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get dayBucket => $composableBuilder(
      column: $table.dayBucket, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get predictionsJson => $composableBuilder(
      column: $table.predictionsJson,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get fetchedAtUtc => $composableBuilder(
      column: $table.fetchedAtUtc, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get validUntilUtc => $composableBuilder(
      column: $table.validUntilUtc, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sizeBytes => $composableBuilder(
      column: $table.sizeBytes, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get lastAccessedUtc => $composableBuilder(
      column: $table.lastAccessedUtc,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get pinned => $composableBuilder(
      column: $table.pinned, builder: (column) => ColumnFilters(column));
}

class $$TideCacheTableOrderingComposer
    extends Composer<_$AppDatabase, $TideCacheTable> {
  $$TideCacheTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get cacheKey => $composableBuilder(
      column: $table.cacheKey, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get stationId => $composableBuilder(
      column: $table.stationId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get dayBucket => $composableBuilder(
      column: $table.dayBucket, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get predictionsJson => $composableBuilder(
      column: $table.predictionsJson,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get fetchedAtUtc => $composableBuilder(
      column: $table.fetchedAtUtc,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get validUntilUtc => $composableBuilder(
      column: $table.validUntilUtc,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sizeBytes => $composableBuilder(
      column: $table.sizeBytes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get lastAccessedUtc => $composableBuilder(
      column: $table.lastAccessedUtc,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get pinned => $composableBuilder(
      column: $table.pinned, builder: (column) => ColumnOrderings(column));
}

class $$TideCacheTableAnnotationComposer
    extends Composer<_$AppDatabase, $TideCacheTable> {
  $$TideCacheTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get cacheKey =>
      $composableBuilder(column: $table.cacheKey, builder: (column) => column);

  GeneratedColumn<String> get stationId =>
      $composableBuilder(column: $table.stationId, builder: (column) => column);

  GeneratedColumn<String> get dayBucket =>
      $composableBuilder(column: $table.dayBucket, builder: (column) => column);

  GeneratedColumn<String> get predictionsJson => $composableBuilder(
      column: $table.predictionsJson, builder: (column) => column);

  GeneratedColumn<int> get fetchedAtUtc => $composableBuilder(
      column: $table.fetchedAtUtc, builder: (column) => column);

  GeneratedColumn<int> get validUntilUtc => $composableBuilder(
      column: $table.validUntilUtc, builder: (column) => column);

  GeneratedColumn<int> get sizeBytes =>
      $composableBuilder(column: $table.sizeBytes, builder: (column) => column);

  GeneratedColumn<int> get lastAccessedUtc => $composableBuilder(
      column: $table.lastAccessedUtc, builder: (column) => column);

  GeneratedColumn<bool> get pinned =>
      $composableBuilder(column: $table.pinned, builder: (column) => column);
}

class $$TideCacheTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TideCacheTable,
    TideCacheRow,
    $$TideCacheTableFilterComposer,
    $$TideCacheTableOrderingComposer,
    $$TideCacheTableAnnotationComposer,
    $$TideCacheTableCreateCompanionBuilder,
    $$TideCacheTableUpdateCompanionBuilder,
    (
      TideCacheRow,
      BaseReferences<_$AppDatabase, $TideCacheTable, TideCacheRow>
    ),
    TideCacheRow,
    PrefetchHooks Function()> {
  $$TideCacheTableTableManager(_$AppDatabase db, $TideCacheTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TideCacheTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TideCacheTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TideCacheTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> cacheKey = const Value.absent(),
            Value<String> stationId = const Value.absent(),
            Value<String> dayBucket = const Value.absent(),
            Value<String> predictionsJson = const Value.absent(),
            Value<int> fetchedAtUtc = const Value.absent(),
            Value<int> validUntilUtc = const Value.absent(),
            Value<int> sizeBytes = const Value.absent(),
            Value<int> lastAccessedUtc = const Value.absent(),
            Value<bool> pinned = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TideCacheCompanion(
            cacheKey: cacheKey,
            stationId: stationId,
            dayBucket: dayBucket,
            predictionsJson: predictionsJson,
            fetchedAtUtc: fetchedAtUtc,
            validUntilUtc: validUntilUtc,
            sizeBytes: sizeBytes,
            lastAccessedUtc: lastAccessedUtc,
            pinned: pinned,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String cacheKey,
            required String stationId,
            required String dayBucket,
            required String predictionsJson,
            required int fetchedAtUtc,
            required int validUntilUtc,
            required int sizeBytes,
            required int lastAccessedUtc,
            Value<bool> pinned = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TideCacheCompanion.insert(
            cacheKey: cacheKey,
            stationId: stationId,
            dayBucket: dayBucket,
            predictionsJson: predictionsJson,
            fetchedAtUtc: fetchedAtUtc,
            validUntilUtc: validUntilUtc,
            sizeBytes: sizeBytes,
            lastAccessedUtc: lastAccessedUtc,
            pinned: pinned,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$TideCacheTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TideCacheTable,
    TideCacheRow,
    $$TideCacheTableFilterComposer,
    $$TideCacheTableOrderingComposer,
    $$TideCacheTableAnnotationComposer,
    $$TideCacheTableCreateCompanionBuilder,
    $$TideCacheTableUpdateCompanionBuilder,
    (
      TideCacheRow,
      BaseReferences<_$AppDatabase, $TideCacheTable, TideCacheRow>
    ),
    TideCacheRow,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CatchesTableTableManager get catches =>
      $$CatchesTableTableManager(_db, _db.catches);
  $$TripPlansTableTableManager get tripPlans =>
      $$TripPlansTableTableManager(_db, _db.tripPlans);
  $$UserPreferencesTableTableTableManager get userPreferencesTable =>
      $$UserPreferencesTableTableTableManager(_db, _db.userPreferencesTable);
  $$SyncQueueTableTableManager get syncQueue =>
      $$SyncQueueTableTableManager(_db, _db.syncQueue);
  $$ConditionsCacheTableTableManager get conditionsCache =>
      $$ConditionsCacheTableTableManager(_db, _db.conditionsCache);
  $$ScoreCacheTableTableManager get scoreCache =>
      $$ScoreCacheTableTableManager(_db, _db.scoreCache);
  $$ChartTileCacheTableTableManager get chartTileCache =>
      $$ChartTileCacheTableTableManager(_db, _db.chartTileCache);
  $$ForecastCacheTableTableManager get forecastCache =>
      $$ForecastCacheTableTableManager(_db, _db.forecastCache);
  $$TideCacheTableTableManager get tideCache =>
      $$TideCacheTableTableManager(_db, _db.tideCache);
}
