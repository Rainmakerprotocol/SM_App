// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $PunchesLocalTable extends PunchesLocal
    with TableInfo<$PunchesLocalTable, PunchesLocalData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PunchesLocalTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _punchIdMeta =
      const VerificationMeta('punchId');
  @override
  late final GeneratedColumn<String> punchId = GeneratedColumn<String>(
      'punch_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _employeeIdMeta =
      const VerificationMeta('employeeId');
  @override
  late final GeneratedColumn<String> employeeId = GeneratedColumn<String>(
      'employee_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _jobIdMeta = const VerificationMeta('jobId');
  @override
  late final GeneratedColumn<String> jobId = GeneratedColumn<String>(
      'job_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _serviceIdMeta =
      const VerificationMeta('serviceId');
  @override
  late final GeneratedColumn<String> serviceId = GeneratedColumn<String>(
      'service_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _punchTypeMeta =
      const VerificationMeta('punchType');
  @override
  late final GeneratedColumn<String> punchType = GeneratedColumn<String>(
      'punch_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _timestampDeviceMeta =
      const VerificationMeta('timestampDevice');
  @override
  late final GeneratedColumn<DateTime> timestampDevice =
      GeneratedColumn<DateTime>('timestamp_device', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _gpsLatMeta = const VerificationMeta('gpsLat');
  @override
  late final GeneratedColumn<double> gpsLat = GeneratedColumn<double>(
      'gps_lat', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _gpsLngMeta = const VerificationMeta('gpsLng');
  @override
  late final GeneratedColumn<double> gpsLng = GeneratedColumn<double>(
      'gps_lng', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _gpsAccuracyMeta =
      const VerificationMeta('gpsAccuracy');
  @override
  late final GeneratedColumn<double> gpsAccuracy = GeneratedColumn<double>(
      'gps_accuracy', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _gpsUnavailableMeta =
      const VerificationMeta('gpsUnavailable');
  @override
  late final GeneratedColumn<bool> gpsUnavailable = GeneratedColumn<bool>(
      'gps_unavailable', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("gps_unavailable" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _syncedMeta = const VerificationMeta('synced');
  @override
  late final GeneratedColumn<bool> synced = GeneratedColumn<bool>(
      'synced', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("synced" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _syncAttemptsMeta =
      const VerificationMeta('syncAttempts');
  @override
  late final GeneratedColumn<int> syncAttempts = GeneratedColumn<int>(
      'sync_attempts', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
      'source', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('mobile_app'));
  static const VerificationMeta _deviceIdMeta =
      const VerificationMeta('deviceId');
  @override
  late final GeneratedColumn<String> deviceId = GeneratedColumn<String>(
      'device_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _lastErrorMeta =
      const VerificationMeta('lastError');
  @override
  late final GeneratedColumn<String> lastError = GeneratedColumn<String>(
      'last_error', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _requiresDisputeMeta =
      const VerificationMeta('requiresDispute');
  @override
  late final GeneratedColumn<bool> requiresDispute = GeneratedColumn<bool>(
      'requires_dispute', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("requires_dispute" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        punchId,
        employeeId,
        jobId,
        serviceId,
        punchType,
        timestampDevice,
        gpsLat,
        gpsLng,
        gpsAccuracy,
        gpsUnavailable,
        synced,
        syncAttempts,
        source,
        deviceId,
        lastError,
        requiresDispute,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'punches_local';
  @override
  VerificationContext validateIntegrity(Insertable<PunchesLocalData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('punch_id')) {
      context.handle(_punchIdMeta,
          punchId.isAcceptableOrUnknown(data['punch_id']!, _punchIdMeta));
    } else if (isInserting) {
      context.missing(_punchIdMeta);
    }
    if (data.containsKey('employee_id')) {
      context.handle(
          _employeeIdMeta,
          employeeId.isAcceptableOrUnknown(
              data['employee_id']!, _employeeIdMeta));
    } else if (isInserting) {
      context.missing(_employeeIdMeta);
    }
    if (data.containsKey('job_id')) {
      context.handle(
          _jobIdMeta, jobId.isAcceptableOrUnknown(data['job_id']!, _jobIdMeta));
    } else if (isInserting) {
      context.missing(_jobIdMeta);
    }
    if (data.containsKey('service_id')) {
      context.handle(_serviceIdMeta,
          serviceId.isAcceptableOrUnknown(data['service_id']!, _serviceIdMeta));
    }
    if (data.containsKey('punch_type')) {
      context.handle(_punchTypeMeta,
          punchType.isAcceptableOrUnknown(data['punch_type']!, _punchTypeMeta));
    } else if (isInserting) {
      context.missing(_punchTypeMeta);
    }
    if (data.containsKey('timestamp_device')) {
      context.handle(
          _timestampDeviceMeta,
          timestampDevice.isAcceptableOrUnknown(
              data['timestamp_device']!, _timestampDeviceMeta));
    } else if (isInserting) {
      context.missing(_timestampDeviceMeta);
    }
    if (data.containsKey('gps_lat')) {
      context.handle(_gpsLatMeta,
          gpsLat.isAcceptableOrUnknown(data['gps_lat']!, _gpsLatMeta));
    }
    if (data.containsKey('gps_lng')) {
      context.handle(_gpsLngMeta,
          gpsLng.isAcceptableOrUnknown(data['gps_lng']!, _gpsLngMeta));
    }
    if (data.containsKey('gps_accuracy')) {
      context.handle(
          _gpsAccuracyMeta,
          gpsAccuracy.isAcceptableOrUnknown(
              data['gps_accuracy']!, _gpsAccuracyMeta));
    }
    if (data.containsKey('gps_unavailable')) {
      context.handle(
          _gpsUnavailableMeta,
          gpsUnavailable.isAcceptableOrUnknown(
              data['gps_unavailable']!, _gpsUnavailableMeta));
    }
    if (data.containsKey('synced')) {
      context.handle(_syncedMeta,
          synced.isAcceptableOrUnknown(data['synced']!, _syncedMeta));
    }
    if (data.containsKey('sync_attempts')) {
      context.handle(
          _syncAttemptsMeta,
          syncAttempts.isAcceptableOrUnknown(
              data['sync_attempts']!, _syncAttemptsMeta));
    }
    if (data.containsKey('source')) {
      context.handle(_sourceMeta,
          source.isAcceptableOrUnknown(data['source']!, _sourceMeta));
    }
    if (data.containsKey('device_id')) {
      context.handle(_deviceIdMeta,
          deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta));
    }
    if (data.containsKey('last_error')) {
      context.handle(_lastErrorMeta,
          lastError.isAcceptableOrUnknown(data['last_error']!, _lastErrorMeta));
    }
    if (data.containsKey('requires_dispute')) {
      context.handle(
          _requiresDisputeMeta,
          requiresDispute.isAcceptableOrUnknown(
              data['requires_dispute']!, _requiresDisputeMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {punchId};
  @override
  PunchesLocalData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PunchesLocalData(
      punchId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}punch_id'])!,
      employeeId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}employee_id'])!,
      jobId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}job_id'])!,
      serviceId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}service_id']),
      punchType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}punch_type'])!,
      timestampDevice: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}timestamp_device'])!,
      gpsLat: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}gps_lat']),
      gpsLng: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}gps_lng']),
      gpsAccuracy: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}gps_accuracy']),
      gpsUnavailable: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}gps_unavailable'])!,
      synced: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}synced'])!,
      syncAttempts: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sync_attempts'])!,
      source: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}source'])!,
      deviceId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}device_id']),
      lastError: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}last_error']),
      requiresDispute: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}requires_dispute'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $PunchesLocalTable createAlias(String alias) {
    return $PunchesLocalTable(attachedDatabase, alias);
  }
}

class PunchesLocalData extends DataClass
    implements Insertable<PunchesLocalData> {
  final String punchId;
  final String employeeId;
  final String jobId;
  final String? serviceId;
  final String punchType;
  final DateTime timestampDevice;
  final double? gpsLat;
  final double? gpsLng;
  final double? gpsAccuracy;
  final bool gpsUnavailable;
  final bool synced;
  final int syncAttempts;
  final String source;
  final String? deviceId;
  final String? lastError;
  final bool requiresDispute;
  final DateTime createdAt;
  final DateTime updatedAt;
  const PunchesLocalData(
      {required this.punchId,
      required this.employeeId,
      required this.jobId,
      this.serviceId,
      required this.punchType,
      required this.timestampDevice,
      this.gpsLat,
      this.gpsLng,
      this.gpsAccuracy,
      required this.gpsUnavailable,
      required this.synced,
      required this.syncAttempts,
      required this.source,
      this.deviceId,
      this.lastError,
      required this.requiresDispute,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['punch_id'] = Variable<String>(punchId);
    map['employee_id'] = Variable<String>(employeeId);
    map['job_id'] = Variable<String>(jobId);
    if (!nullToAbsent || serviceId != null) {
      map['service_id'] = Variable<String>(serviceId);
    }
    map['punch_type'] = Variable<String>(punchType);
    map['timestamp_device'] = Variable<DateTime>(timestampDevice);
    if (!nullToAbsent || gpsLat != null) {
      map['gps_lat'] = Variable<double>(gpsLat);
    }
    if (!nullToAbsent || gpsLng != null) {
      map['gps_lng'] = Variable<double>(gpsLng);
    }
    if (!nullToAbsent || gpsAccuracy != null) {
      map['gps_accuracy'] = Variable<double>(gpsAccuracy);
    }
    map['gps_unavailable'] = Variable<bool>(gpsUnavailable);
    map['synced'] = Variable<bool>(synced);
    map['sync_attempts'] = Variable<int>(syncAttempts);
    map['source'] = Variable<String>(source);
    if (!nullToAbsent || deviceId != null) {
      map['device_id'] = Variable<String>(deviceId);
    }
    if (!nullToAbsent || lastError != null) {
      map['last_error'] = Variable<String>(lastError);
    }
    map['requires_dispute'] = Variable<bool>(requiresDispute);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  PunchesLocalCompanion toCompanion(bool nullToAbsent) {
    return PunchesLocalCompanion(
      punchId: Value(punchId),
      employeeId: Value(employeeId),
      jobId: Value(jobId),
      serviceId: serviceId == null && nullToAbsent
          ? const Value.absent()
          : Value(serviceId),
      punchType: Value(punchType),
      timestampDevice: Value(timestampDevice),
      gpsLat:
          gpsLat == null && nullToAbsent ? const Value.absent() : Value(gpsLat),
      gpsLng:
          gpsLng == null && nullToAbsent ? const Value.absent() : Value(gpsLng),
      gpsAccuracy: gpsAccuracy == null && nullToAbsent
          ? const Value.absent()
          : Value(gpsAccuracy),
      gpsUnavailable: Value(gpsUnavailable),
      synced: Value(synced),
      syncAttempts: Value(syncAttempts),
      source: Value(source),
      deviceId: deviceId == null && nullToAbsent
          ? const Value.absent()
          : Value(deviceId),
      lastError: lastError == null && nullToAbsent
          ? const Value.absent()
          : Value(lastError),
      requiresDispute: Value(requiresDispute),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory PunchesLocalData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PunchesLocalData(
      punchId: serializer.fromJson<String>(json['punchId']),
      employeeId: serializer.fromJson<String>(json['employeeId']),
      jobId: serializer.fromJson<String>(json['jobId']),
      serviceId: serializer.fromJson<String?>(json['serviceId']),
      punchType: serializer.fromJson<String>(json['punchType']),
      timestampDevice: serializer.fromJson<DateTime>(json['timestampDevice']),
      gpsLat: serializer.fromJson<double?>(json['gpsLat']),
      gpsLng: serializer.fromJson<double?>(json['gpsLng']),
      gpsAccuracy: serializer.fromJson<double?>(json['gpsAccuracy']),
      gpsUnavailable: serializer.fromJson<bool>(json['gpsUnavailable']),
      synced: serializer.fromJson<bool>(json['synced']),
      syncAttempts: serializer.fromJson<int>(json['syncAttempts']),
      source: serializer.fromJson<String>(json['source']),
      deviceId: serializer.fromJson<String?>(json['deviceId']),
      lastError: serializer.fromJson<String?>(json['lastError']),
      requiresDispute: serializer.fromJson<bool>(json['requiresDispute']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'punchId': serializer.toJson<String>(punchId),
      'employeeId': serializer.toJson<String>(employeeId),
      'jobId': serializer.toJson<String>(jobId),
      'serviceId': serializer.toJson<String?>(serviceId),
      'punchType': serializer.toJson<String>(punchType),
      'timestampDevice': serializer.toJson<DateTime>(timestampDevice),
      'gpsLat': serializer.toJson<double?>(gpsLat),
      'gpsLng': serializer.toJson<double?>(gpsLng),
      'gpsAccuracy': serializer.toJson<double?>(gpsAccuracy),
      'gpsUnavailable': serializer.toJson<bool>(gpsUnavailable),
      'synced': serializer.toJson<bool>(synced),
      'syncAttempts': serializer.toJson<int>(syncAttempts),
      'source': serializer.toJson<String>(source),
      'deviceId': serializer.toJson<String?>(deviceId),
      'lastError': serializer.toJson<String?>(lastError),
      'requiresDispute': serializer.toJson<bool>(requiresDispute),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  PunchesLocalData copyWith(
          {String? punchId,
          String? employeeId,
          String? jobId,
          Value<String?> serviceId = const Value.absent(),
          String? punchType,
          DateTime? timestampDevice,
          Value<double?> gpsLat = const Value.absent(),
          Value<double?> gpsLng = const Value.absent(),
          Value<double?> gpsAccuracy = const Value.absent(),
          bool? gpsUnavailable,
          bool? synced,
          int? syncAttempts,
          String? source,
          Value<String?> deviceId = const Value.absent(),
          Value<String?> lastError = const Value.absent(),
          bool? requiresDispute,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      PunchesLocalData(
        punchId: punchId ?? this.punchId,
        employeeId: employeeId ?? this.employeeId,
        jobId: jobId ?? this.jobId,
        serviceId: serviceId.present ? serviceId.value : this.serviceId,
        punchType: punchType ?? this.punchType,
        timestampDevice: timestampDevice ?? this.timestampDevice,
        gpsLat: gpsLat.present ? gpsLat.value : this.gpsLat,
        gpsLng: gpsLng.present ? gpsLng.value : this.gpsLng,
        gpsAccuracy: gpsAccuracy.present ? gpsAccuracy.value : this.gpsAccuracy,
        gpsUnavailable: gpsUnavailable ?? this.gpsUnavailable,
        synced: synced ?? this.synced,
        syncAttempts: syncAttempts ?? this.syncAttempts,
        source: source ?? this.source,
        deviceId: deviceId.present ? deviceId.value : this.deviceId,
        lastError: lastError.present ? lastError.value : this.lastError,
        requiresDispute: requiresDispute ?? this.requiresDispute,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  PunchesLocalData copyWithCompanion(PunchesLocalCompanion data) {
    return PunchesLocalData(
      punchId: data.punchId.present ? data.punchId.value : this.punchId,
      employeeId:
          data.employeeId.present ? data.employeeId.value : this.employeeId,
      jobId: data.jobId.present ? data.jobId.value : this.jobId,
      serviceId: data.serviceId.present ? data.serviceId.value : this.serviceId,
      punchType: data.punchType.present ? data.punchType.value : this.punchType,
      timestampDevice: data.timestampDevice.present
          ? data.timestampDevice.value
          : this.timestampDevice,
      gpsLat: data.gpsLat.present ? data.gpsLat.value : this.gpsLat,
      gpsLng: data.gpsLng.present ? data.gpsLng.value : this.gpsLng,
      gpsAccuracy:
          data.gpsAccuracy.present ? data.gpsAccuracy.value : this.gpsAccuracy,
      gpsUnavailable: data.gpsUnavailable.present
          ? data.gpsUnavailable.value
          : this.gpsUnavailable,
      synced: data.synced.present ? data.synced.value : this.synced,
      syncAttempts: data.syncAttempts.present
          ? data.syncAttempts.value
          : this.syncAttempts,
      source: data.source.present ? data.source.value : this.source,
      deviceId: data.deviceId.present ? data.deviceId.value : this.deviceId,
      lastError: data.lastError.present ? data.lastError.value : this.lastError,
      requiresDispute: data.requiresDispute.present
          ? data.requiresDispute.value
          : this.requiresDispute,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PunchesLocalData(')
          ..write('punchId: $punchId, ')
          ..write('employeeId: $employeeId, ')
          ..write('jobId: $jobId, ')
          ..write('serviceId: $serviceId, ')
          ..write('punchType: $punchType, ')
          ..write('timestampDevice: $timestampDevice, ')
          ..write('gpsLat: $gpsLat, ')
          ..write('gpsLng: $gpsLng, ')
          ..write('gpsAccuracy: $gpsAccuracy, ')
          ..write('gpsUnavailable: $gpsUnavailable, ')
          ..write('synced: $synced, ')
          ..write('syncAttempts: $syncAttempts, ')
          ..write('source: $source, ')
          ..write('deviceId: $deviceId, ')
          ..write('lastError: $lastError, ')
          ..write('requiresDispute: $requiresDispute, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      punchId,
      employeeId,
      jobId,
      serviceId,
      punchType,
      timestampDevice,
      gpsLat,
      gpsLng,
      gpsAccuracy,
      gpsUnavailable,
      synced,
      syncAttempts,
      source,
      deviceId,
      lastError,
      requiresDispute,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PunchesLocalData &&
          other.punchId == this.punchId &&
          other.employeeId == this.employeeId &&
          other.jobId == this.jobId &&
          other.serviceId == this.serviceId &&
          other.punchType == this.punchType &&
          other.timestampDevice == this.timestampDevice &&
          other.gpsLat == this.gpsLat &&
          other.gpsLng == this.gpsLng &&
          other.gpsAccuracy == this.gpsAccuracy &&
          other.gpsUnavailable == this.gpsUnavailable &&
          other.synced == this.synced &&
          other.syncAttempts == this.syncAttempts &&
          other.source == this.source &&
          other.deviceId == this.deviceId &&
          other.lastError == this.lastError &&
          other.requiresDispute == this.requiresDispute &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class PunchesLocalCompanion extends UpdateCompanion<PunchesLocalData> {
  final Value<String> punchId;
  final Value<String> employeeId;
  final Value<String> jobId;
  final Value<String?> serviceId;
  final Value<String> punchType;
  final Value<DateTime> timestampDevice;
  final Value<double?> gpsLat;
  final Value<double?> gpsLng;
  final Value<double?> gpsAccuracy;
  final Value<bool> gpsUnavailable;
  final Value<bool> synced;
  final Value<int> syncAttempts;
  final Value<String> source;
  final Value<String?> deviceId;
  final Value<String?> lastError;
  final Value<bool> requiresDispute;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const PunchesLocalCompanion({
    this.punchId = const Value.absent(),
    this.employeeId = const Value.absent(),
    this.jobId = const Value.absent(),
    this.serviceId = const Value.absent(),
    this.punchType = const Value.absent(),
    this.timestampDevice = const Value.absent(),
    this.gpsLat = const Value.absent(),
    this.gpsLng = const Value.absent(),
    this.gpsAccuracy = const Value.absent(),
    this.gpsUnavailable = const Value.absent(),
    this.synced = const Value.absent(),
    this.syncAttempts = const Value.absent(),
    this.source = const Value.absent(),
    this.deviceId = const Value.absent(),
    this.lastError = const Value.absent(),
    this.requiresDispute = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PunchesLocalCompanion.insert({
    required String punchId,
    required String employeeId,
    required String jobId,
    this.serviceId = const Value.absent(),
    required String punchType,
    required DateTime timestampDevice,
    this.gpsLat = const Value.absent(),
    this.gpsLng = const Value.absent(),
    this.gpsAccuracy = const Value.absent(),
    this.gpsUnavailable = const Value.absent(),
    this.synced = const Value.absent(),
    this.syncAttempts = const Value.absent(),
    this.source = const Value.absent(),
    this.deviceId = const Value.absent(),
    this.lastError = const Value.absent(),
    this.requiresDispute = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : punchId = Value(punchId),
        employeeId = Value(employeeId),
        jobId = Value(jobId),
        punchType = Value(punchType),
        timestampDevice = Value(timestampDevice);
  static Insertable<PunchesLocalData> custom({
    Expression<String>? punchId,
    Expression<String>? employeeId,
    Expression<String>? jobId,
    Expression<String>? serviceId,
    Expression<String>? punchType,
    Expression<DateTime>? timestampDevice,
    Expression<double>? gpsLat,
    Expression<double>? gpsLng,
    Expression<double>? gpsAccuracy,
    Expression<bool>? gpsUnavailable,
    Expression<bool>? synced,
    Expression<int>? syncAttempts,
    Expression<String>? source,
    Expression<String>? deviceId,
    Expression<String>? lastError,
    Expression<bool>? requiresDispute,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (punchId != null) 'punch_id': punchId,
      if (employeeId != null) 'employee_id': employeeId,
      if (jobId != null) 'job_id': jobId,
      if (serviceId != null) 'service_id': serviceId,
      if (punchType != null) 'punch_type': punchType,
      if (timestampDevice != null) 'timestamp_device': timestampDevice,
      if (gpsLat != null) 'gps_lat': gpsLat,
      if (gpsLng != null) 'gps_lng': gpsLng,
      if (gpsAccuracy != null) 'gps_accuracy': gpsAccuracy,
      if (gpsUnavailable != null) 'gps_unavailable': gpsUnavailable,
      if (synced != null) 'synced': synced,
      if (syncAttempts != null) 'sync_attempts': syncAttempts,
      if (source != null) 'source': source,
      if (deviceId != null) 'device_id': deviceId,
      if (lastError != null) 'last_error': lastError,
      if (requiresDispute != null) 'requires_dispute': requiresDispute,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PunchesLocalCompanion copyWith(
      {Value<String>? punchId,
      Value<String>? employeeId,
      Value<String>? jobId,
      Value<String?>? serviceId,
      Value<String>? punchType,
      Value<DateTime>? timestampDevice,
      Value<double?>? gpsLat,
      Value<double?>? gpsLng,
      Value<double?>? gpsAccuracy,
      Value<bool>? gpsUnavailable,
      Value<bool>? synced,
      Value<int>? syncAttempts,
      Value<String>? source,
      Value<String?>? deviceId,
      Value<String?>? lastError,
      Value<bool>? requiresDispute,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return PunchesLocalCompanion(
      punchId: punchId ?? this.punchId,
      employeeId: employeeId ?? this.employeeId,
      jobId: jobId ?? this.jobId,
      serviceId: serviceId ?? this.serviceId,
      punchType: punchType ?? this.punchType,
      timestampDevice: timestampDevice ?? this.timestampDevice,
      gpsLat: gpsLat ?? this.gpsLat,
      gpsLng: gpsLng ?? this.gpsLng,
      gpsAccuracy: gpsAccuracy ?? this.gpsAccuracy,
      gpsUnavailable: gpsUnavailable ?? this.gpsUnavailable,
      synced: synced ?? this.synced,
      syncAttempts: syncAttempts ?? this.syncAttempts,
      source: source ?? this.source,
      deviceId: deviceId ?? this.deviceId,
      lastError: lastError ?? this.lastError,
      requiresDispute: requiresDispute ?? this.requiresDispute,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (punchId.present) {
      map['punch_id'] = Variable<String>(punchId.value);
    }
    if (employeeId.present) {
      map['employee_id'] = Variable<String>(employeeId.value);
    }
    if (jobId.present) {
      map['job_id'] = Variable<String>(jobId.value);
    }
    if (serviceId.present) {
      map['service_id'] = Variable<String>(serviceId.value);
    }
    if (punchType.present) {
      map['punch_type'] = Variable<String>(punchType.value);
    }
    if (timestampDevice.present) {
      map['timestamp_device'] = Variable<DateTime>(timestampDevice.value);
    }
    if (gpsLat.present) {
      map['gps_lat'] = Variable<double>(gpsLat.value);
    }
    if (gpsLng.present) {
      map['gps_lng'] = Variable<double>(gpsLng.value);
    }
    if (gpsAccuracy.present) {
      map['gps_accuracy'] = Variable<double>(gpsAccuracy.value);
    }
    if (gpsUnavailable.present) {
      map['gps_unavailable'] = Variable<bool>(gpsUnavailable.value);
    }
    if (synced.present) {
      map['synced'] = Variable<bool>(synced.value);
    }
    if (syncAttempts.present) {
      map['sync_attempts'] = Variable<int>(syncAttempts.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (deviceId.present) {
      map['device_id'] = Variable<String>(deviceId.value);
    }
    if (lastError.present) {
      map['last_error'] = Variable<String>(lastError.value);
    }
    if (requiresDispute.present) {
      map['requires_dispute'] = Variable<bool>(requiresDispute.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PunchesLocalCompanion(')
          ..write('punchId: $punchId, ')
          ..write('employeeId: $employeeId, ')
          ..write('jobId: $jobId, ')
          ..write('serviceId: $serviceId, ')
          ..write('punchType: $punchType, ')
          ..write('timestampDevice: $timestampDevice, ')
          ..write('gpsLat: $gpsLat, ')
          ..write('gpsLng: $gpsLng, ')
          ..write('gpsAccuracy: $gpsAccuracy, ')
          ..write('gpsUnavailable: $gpsUnavailable, ')
          ..write('synced: $synced, ')
          ..write('syncAttempts: $syncAttempts, ')
          ..write('source: $source, ')
          ..write('deviceId: $deviceId, ')
          ..write('lastError: $lastError, ')
          ..write('requiresDispute: $requiresDispute, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $JobsLocalTable extends JobsLocal
    with TableInfo<$JobsLocalTable, JobsLocalData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $JobsLocalTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _jobIdMeta = const VerificationMeta('jobId');
  @override
  late final GeneratedColumn<String> jobId = GeneratedColumn<String>(
      'job_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _serviceIdMeta =
      const VerificationMeta('serviceId');
  @override
  late final GeneratedColumn<String> serviceId = GeneratedColumn<String>(
      'service_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _customerNameMeta =
      const VerificationMeta('customerName');
  @override
  late final GeneratedColumn<String> customerName = GeneratedColumn<String>(
      'customer_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _addressMeta =
      const VerificationMeta('address');
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
      'address', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _scheduledDateMeta =
      const VerificationMeta('scheduledDate');
  @override
  late final GeneratedColumn<DateTime> scheduledDate =
      GeneratedColumn<DateTime>('scheduled_date', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _foremanIdMeta =
      const VerificationMeta('foremanId');
  @override
  late final GeneratedColumn<String> foremanId = GeneratedColumn<String>(
      'foreman_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _crewListJsonMeta =
      const VerificationMeta('crewListJson');
  @override
  late final GeneratedColumn<String> crewListJson = GeneratedColumn<String>(
      'crew_list_json', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('[]'));
  static const VerificationMeta _crewHashMeta =
      const VerificationMeta('crewHash');
  @override
  late final GeneratedColumn<String> crewHash = GeneratedColumn<String>(
      'crew_hash', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _lastUpdatedMeta =
      const VerificationMeta('lastUpdated');
  @override
  late final GeneratedColumn<DateTime> lastUpdated = GeneratedColumn<DateTime>(
      'last_updated', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _syncedMeta = const VerificationMeta('synced');
  @override
  late final GeneratedColumn<bool> synced = GeneratedColumn<bool>(
      'synced', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("synced" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        jobId,
        serviceId,
        customerName,
        address,
        scheduledDate,
        foremanId,
        crewListJson,
        crewHash,
        lastUpdated,
        synced
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'jobs_local';
  @override
  VerificationContext validateIntegrity(Insertable<JobsLocalData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('job_id')) {
      context.handle(
          _jobIdMeta, jobId.isAcceptableOrUnknown(data['job_id']!, _jobIdMeta));
    } else if (isInserting) {
      context.missing(_jobIdMeta);
    }
    if (data.containsKey('service_id')) {
      context.handle(_serviceIdMeta,
          serviceId.isAcceptableOrUnknown(data['service_id']!, _serviceIdMeta));
    } else if (isInserting) {
      context.missing(_serviceIdMeta);
    }
    if (data.containsKey('customer_name')) {
      context.handle(
          _customerNameMeta,
          customerName.isAcceptableOrUnknown(
              data['customer_name']!, _customerNameMeta));
    } else if (isInserting) {
      context.missing(_customerNameMeta);
    }
    if (data.containsKey('address')) {
      context.handle(_addressMeta,
          address.isAcceptableOrUnknown(data['address']!, _addressMeta));
    }
    if (data.containsKey('scheduled_date')) {
      context.handle(
          _scheduledDateMeta,
          scheduledDate.isAcceptableOrUnknown(
              data['scheduled_date']!, _scheduledDateMeta));
    } else if (isInserting) {
      context.missing(_scheduledDateMeta);
    }
    if (data.containsKey('foreman_id')) {
      context.handle(_foremanIdMeta,
          foremanId.isAcceptableOrUnknown(data['foreman_id']!, _foremanIdMeta));
    }
    if (data.containsKey('crew_list_json')) {
      context.handle(
          _crewListJsonMeta,
          crewListJson.isAcceptableOrUnknown(
              data['crew_list_json']!, _crewListJsonMeta));
    }
    if (data.containsKey('crew_hash')) {
      context.handle(_crewHashMeta,
          crewHash.isAcceptableOrUnknown(data['crew_hash']!, _crewHashMeta));
    }
    if (data.containsKey('last_updated')) {
      context.handle(
          _lastUpdatedMeta,
          lastUpdated.isAcceptableOrUnknown(
              data['last_updated']!, _lastUpdatedMeta));
    }
    if (data.containsKey('synced')) {
      context.handle(_syncedMeta,
          synced.isAcceptableOrUnknown(data['synced']!, _syncedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {jobId};
  @override
  JobsLocalData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return JobsLocalData(
      jobId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}job_id'])!,
      serviceId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}service_id'])!,
      customerName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}customer_name'])!,
      address: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}address']),
      scheduledDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}scheduled_date'])!,
      foremanId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}foreman_id']),
      crewListJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}crew_list_json'])!,
      crewHash: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}crew_hash']),
      lastUpdated: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_updated'])!,
      synced: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}synced'])!,
    );
  }

  @override
  $JobsLocalTable createAlias(String alias) {
    return $JobsLocalTable(attachedDatabase, alias);
  }
}

class JobsLocalData extends DataClass implements Insertable<JobsLocalData> {
  final String jobId;
  final String serviceId;
  final String customerName;
  final String? address;
  final DateTime scheduledDate;
  final String? foremanId;
  final String crewListJson;
  final String? crewHash;
  final DateTime lastUpdated;
  final bool synced;
  const JobsLocalData(
      {required this.jobId,
      required this.serviceId,
      required this.customerName,
      this.address,
      required this.scheduledDate,
      this.foremanId,
      required this.crewListJson,
      this.crewHash,
      required this.lastUpdated,
      required this.synced});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['job_id'] = Variable<String>(jobId);
    map['service_id'] = Variable<String>(serviceId);
    map['customer_name'] = Variable<String>(customerName);
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    map['scheduled_date'] = Variable<DateTime>(scheduledDate);
    if (!nullToAbsent || foremanId != null) {
      map['foreman_id'] = Variable<String>(foremanId);
    }
    map['crew_list_json'] = Variable<String>(crewListJson);
    if (!nullToAbsent || crewHash != null) {
      map['crew_hash'] = Variable<String>(crewHash);
    }
    map['last_updated'] = Variable<DateTime>(lastUpdated);
    map['synced'] = Variable<bool>(synced);
    return map;
  }

  JobsLocalCompanion toCompanion(bool nullToAbsent) {
    return JobsLocalCompanion(
      jobId: Value(jobId),
      serviceId: Value(serviceId),
      customerName: Value(customerName),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      scheduledDate: Value(scheduledDate),
      foremanId: foremanId == null && nullToAbsent
          ? const Value.absent()
          : Value(foremanId),
      crewListJson: Value(crewListJson),
      crewHash: crewHash == null && nullToAbsent
          ? const Value.absent()
          : Value(crewHash),
      lastUpdated: Value(lastUpdated),
      synced: Value(synced),
    );
  }

  factory JobsLocalData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return JobsLocalData(
      jobId: serializer.fromJson<String>(json['jobId']),
      serviceId: serializer.fromJson<String>(json['serviceId']),
      customerName: serializer.fromJson<String>(json['customerName']),
      address: serializer.fromJson<String?>(json['address']),
      scheduledDate: serializer.fromJson<DateTime>(json['scheduledDate']),
      foremanId: serializer.fromJson<String?>(json['foremanId']),
      crewListJson: serializer.fromJson<String>(json['crewListJson']),
      crewHash: serializer.fromJson<String?>(json['crewHash']),
      lastUpdated: serializer.fromJson<DateTime>(json['lastUpdated']),
      synced: serializer.fromJson<bool>(json['synced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'jobId': serializer.toJson<String>(jobId),
      'serviceId': serializer.toJson<String>(serviceId),
      'customerName': serializer.toJson<String>(customerName),
      'address': serializer.toJson<String?>(address),
      'scheduledDate': serializer.toJson<DateTime>(scheduledDate),
      'foremanId': serializer.toJson<String?>(foremanId),
      'crewListJson': serializer.toJson<String>(crewListJson),
      'crewHash': serializer.toJson<String?>(crewHash),
      'lastUpdated': serializer.toJson<DateTime>(lastUpdated),
      'synced': serializer.toJson<bool>(synced),
    };
  }

  JobsLocalData copyWith(
          {String? jobId,
          String? serviceId,
          String? customerName,
          Value<String?> address = const Value.absent(),
          DateTime? scheduledDate,
          Value<String?> foremanId = const Value.absent(),
          String? crewListJson,
          Value<String?> crewHash = const Value.absent(),
          DateTime? lastUpdated,
          bool? synced}) =>
      JobsLocalData(
        jobId: jobId ?? this.jobId,
        serviceId: serviceId ?? this.serviceId,
        customerName: customerName ?? this.customerName,
        address: address.present ? address.value : this.address,
        scheduledDate: scheduledDate ?? this.scheduledDate,
        foremanId: foremanId.present ? foremanId.value : this.foremanId,
        crewListJson: crewListJson ?? this.crewListJson,
        crewHash: crewHash.present ? crewHash.value : this.crewHash,
        lastUpdated: lastUpdated ?? this.lastUpdated,
        synced: synced ?? this.synced,
      );
  JobsLocalData copyWithCompanion(JobsLocalCompanion data) {
    return JobsLocalData(
      jobId: data.jobId.present ? data.jobId.value : this.jobId,
      serviceId: data.serviceId.present ? data.serviceId.value : this.serviceId,
      customerName: data.customerName.present
          ? data.customerName.value
          : this.customerName,
      address: data.address.present ? data.address.value : this.address,
      scheduledDate: data.scheduledDate.present
          ? data.scheduledDate.value
          : this.scheduledDate,
      foremanId: data.foremanId.present ? data.foremanId.value : this.foremanId,
      crewListJson: data.crewListJson.present
          ? data.crewListJson.value
          : this.crewListJson,
      crewHash: data.crewHash.present ? data.crewHash.value : this.crewHash,
      lastUpdated:
          data.lastUpdated.present ? data.lastUpdated.value : this.lastUpdated,
      synced: data.synced.present ? data.synced.value : this.synced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('JobsLocalData(')
          ..write('jobId: $jobId, ')
          ..write('serviceId: $serviceId, ')
          ..write('customerName: $customerName, ')
          ..write('address: $address, ')
          ..write('scheduledDate: $scheduledDate, ')
          ..write('foremanId: $foremanId, ')
          ..write('crewListJson: $crewListJson, ')
          ..write('crewHash: $crewHash, ')
          ..write('lastUpdated: $lastUpdated, ')
          ..write('synced: $synced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(jobId, serviceId, customerName, address,
      scheduledDate, foremanId, crewListJson, crewHash, lastUpdated, synced);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is JobsLocalData &&
          other.jobId == this.jobId &&
          other.serviceId == this.serviceId &&
          other.customerName == this.customerName &&
          other.address == this.address &&
          other.scheduledDate == this.scheduledDate &&
          other.foremanId == this.foremanId &&
          other.crewListJson == this.crewListJson &&
          other.crewHash == this.crewHash &&
          other.lastUpdated == this.lastUpdated &&
          other.synced == this.synced);
}

class JobsLocalCompanion extends UpdateCompanion<JobsLocalData> {
  final Value<String> jobId;
  final Value<String> serviceId;
  final Value<String> customerName;
  final Value<String?> address;
  final Value<DateTime> scheduledDate;
  final Value<String?> foremanId;
  final Value<String> crewListJson;
  final Value<String?> crewHash;
  final Value<DateTime> lastUpdated;
  final Value<bool> synced;
  final Value<int> rowid;
  const JobsLocalCompanion({
    this.jobId = const Value.absent(),
    this.serviceId = const Value.absent(),
    this.customerName = const Value.absent(),
    this.address = const Value.absent(),
    this.scheduledDate = const Value.absent(),
    this.foremanId = const Value.absent(),
    this.crewListJson = const Value.absent(),
    this.crewHash = const Value.absent(),
    this.lastUpdated = const Value.absent(),
    this.synced = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  JobsLocalCompanion.insert({
    required String jobId,
    required String serviceId,
    required String customerName,
    this.address = const Value.absent(),
    required DateTime scheduledDate,
    this.foremanId = const Value.absent(),
    this.crewListJson = const Value.absent(),
    this.crewHash = const Value.absent(),
    this.lastUpdated = const Value.absent(),
    this.synced = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : jobId = Value(jobId),
        serviceId = Value(serviceId),
        customerName = Value(customerName),
        scheduledDate = Value(scheduledDate);
  static Insertable<JobsLocalData> custom({
    Expression<String>? jobId,
    Expression<String>? serviceId,
    Expression<String>? customerName,
    Expression<String>? address,
    Expression<DateTime>? scheduledDate,
    Expression<String>? foremanId,
    Expression<String>? crewListJson,
    Expression<String>? crewHash,
    Expression<DateTime>? lastUpdated,
    Expression<bool>? synced,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (jobId != null) 'job_id': jobId,
      if (serviceId != null) 'service_id': serviceId,
      if (customerName != null) 'customer_name': customerName,
      if (address != null) 'address': address,
      if (scheduledDate != null) 'scheduled_date': scheduledDate,
      if (foremanId != null) 'foreman_id': foremanId,
      if (crewListJson != null) 'crew_list_json': crewListJson,
      if (crewHash != null) 'crew_hash': crewHash,
      if (lastUpdated != null) 'last_updated': lastUpdated,
      if (synced != null) 'synced': synced,
      if (rowid != null) 'rowid': rowid,
    });
  }

  JobsLocalCompanion copyWith(
      {Value<String>? jobId,
      Value<String>? serviceId,
      Value<String>? customerName,
      Value<String?>? address,
      Value<DateTime>? scheduledDate,
      Value<String?>? foremanId,
      Value<String>? crewListJson,
      Value<String?>? crewHash,
      Value<DateTime>? lastUpdated,
      Value<bool>? synced,
      Value<int>? rowid}) {
    return JobsLocalCompanion(
      jobId: jobId ?? this.jobId,
      serviceId: serviceId ?? this.serviceId,
      customerName: customerName ?? this.customerName,
      address: address ?? this.address,
      scheduledDate: scheduledDate ?? this.scheduledDate,
      foremanId: foremanId ?? this.foremanId,
      crewListJson: crewListJson ?? this.crewListJson,
      crewHash: crewHash ?? this.crewHash,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      synced: synced ?? this.synced,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (jobId.present) {
      map['job_id'] = Variable<String>(jobId.value);
    }
    if (serviceId.present) {
      map['service_id'] = Variable<String>(serviceId.value);
    }
    if (customerName.present) {
      map['customer_name'] = Variable<String>(customerName.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (scheduledDate.present) {
      map['scheduled_date'] = Variable<DateTime>(scheduledDate.value);
    }
    if (foremanId.present) {
      map['foreman_id'] = Variable<String>(foremanId.value);
    }
    if (crewListJson.present) {
      map['crew_list_json'] = Variable<String>(crewListJson.value);
    }
    if (crewHash.present) {
      map['crew_hash'] = Variable<String>(crewHash.value);
    }
    if (lastUpdated.present) {
      map['last_updated'] = Variable<DateTime>(lastUpdated.value);
    }
    if (synced.present) {
      map['synced'] = Variable<bool>(synced.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('JobsLocalCompanion(')
          ..write('jobId: $jobId, ')
          ..write('serviceId: $serviceId, ')
          ..write('customerName: $customerName, ')
          ..write('address: $address, ')
          ..write('scheduledDate: $scheduledDate, ')
          ..write('foremanId: $foremanId, ')
          ..write('crewListJson: $crewListJson, ')
          ..write('crewHash: $crewHash, ')
          ..write('lastUpdated: $lastUpdated, ')
          ..write('synced: $synced, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $JobFeedStateLocalTable extends JobFeedStateLocal
    with TableInfo<$JobFeedStateLocalTable, JobFeedStateLocalData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $JobFeedStateLocalTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _employeeIdMeta =
      const VerificationMeta('employeeId');
  @override
  late final GeneratedColumn<String> employeeId = GeneratedColumn<String>(
      'employee_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _rangeStartMeta =
      const VerificationMeta('rangeStart');
  @override
  late final GeneratedColumn<DateTime> rangeStart = GeneratedColumn<DateTime>(
      'range_start', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _rangeEndMeta =
      const VerificationMeta('rangeEnd');
  @override
  late final GeneratedColumn<DateTime> rangeEnd = GeneratedColumn<DateTime>(
      'range_end', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _lastRefreshedMeta =
      const VerificationMeta('lastRefreshed');
  @override
  late final GeneratedColumn<DateTime> lastRefreshed =
      GeneratedColumn<DateTime>('last_refreshed', aliasedName, false,
          type: DriftSqlType.dateTime,
          requiredDuringInsert: false,
          defaultValue: currentDateAndTime);
  static const VerificationMeta _apiVersionMeta =
      const VerificationMeta('apiVersion');
  @override
  late final GeneratedColumn<String> apiVersion = GeneratedColumn<String>(
      'api_version', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _nextCursorMeta =
      const VerificationMeta('nextCursor');
  @override
  late final GeneratedColumn<String> nextCursor = GeneratedColumn<String>(
      'next_cursor', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [employeeId, rangeStart, rangeEnd, lastRefreshed, apiVersion, nextCursor];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'job_feed_state_local';
  @override
  VerificationContext validateIntegrity(
      Insertable<JobFeedStateLocalData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('employee_id')) {
      context.handle(
          _employeeIdMeta,
          employeeId.isAcceptableOrUnknown(
              data['employee_id']!, _employeeIdMeta));
    } else if (isInserting) {
      context.missing(_employeeIdMeta);
    }
    if (data.containsKey('range_start')) {
      context.handle(
          _rangeStartMeta,
          rangeStart.isAcceptableOrUnknown(
              data['range_start']!, _rangeStartMeta));
    }
    if (data.containsKey('range_end')) {
      context.handle(_rangeEndMeta,
          rangeEnd.isAcceptableOrUnknown(data['range_end']!, _rangeEndMeta));
    }
    if (data.containsKey('last_refreshed')) {
      context.handle(
          _lastRefreshedMeta,
          lastRefreshed.isAcceptableOrUnknown(
              data['last_refreshed']!, _lastRefreshedMeta));
    }
    if (data.containsKey('api_version')) {
      context.handle(
          _apiVersionMeta,
          apiVersion.isAcceptableOrUnknown(
              data['api_version']!, _apiVersionMeta));
    }
    if (data.containsKey('next_cursor')) {
      context.handle(
          _nextCursorMeta,
          nextCursor.isAcceptableOrUnknown(
              data['next_cursor']!, _nextCursorMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {employeeId};
  @override
  JobFeedStateLocalData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return JobFeedStateLocalData(
      employeeId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}employee_id'])!,
      rangeStart: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}range_start']),
      rangeEnd: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}range_end']),
      lastRefreshed: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}last_refreshed'])!,
      apiVersion: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}api_version']),
      nextCursor: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}next_cursor']),
    );
  }

  @override
  $JobFeedStateLocalTable createAlias(String alias) {
    return $JobFeedStateLocalTable(attachedDatabase, alias);
  }
}

class JobFeedStateLocalData extends DataClass
    implements Insertable<JobFeedStateLocalData> {
  final String employeeId;
  final DateTime? rangeStart;
  final DateTime? rangeEnd;
  final DateTime lastRefreshed;
  final String? apiVersion;
  final String? nextCursor;
  const JobFeedStateLocalData(
      {required this.employeeId,
      this.rangeStart,
      this.rangeEnd,
      required this.lastRefreshed,
      this.apiVersion,
      this.nextCursor});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['employee_id'] = Variable<String>(employeeId);
    if (!nullToAbsent || rangeStart != null) {
      map['range_start'] = Variable<DateTime>(rangeStart);
    }
    if (!nullToAbsent || rangeEnd != null) {
      map['range_end'] = Variable<DateTime>(rangeEnd);
    }
    map['last_refreshed'] = Variable<DateTime>(lastRefreshed);
    if (!nullToAbsent || apiVersion != null) {
      map['api_version'] = Variable<String>(apiVersion);
    }
    if (!nullToAbsent || nextCursor != null) {
      map['next_cursor'] = Variable<String>(nextCursor);
    }
    return map;
  }

  JobFeedStateLocalCompanion toCompanion(bool nullToAbsent) {
    return JobFeedStateLocalCompanion(
      employeeId: Value(employeeId),
      rangeStart: rangeStart == null && nullToAbsent
          ? const Value.absent()
          : Value(rangeStart),
      rangeEnd: rangeEnd == null && nullToAbsent
          ? const Value.absent()
          : Value(rangeEnd),
      lastRefreshed: Value(lastRefreshed),
      apiVersion: apiVersion == null && nullToAbsent
          ? const Value.absent()
          : Value(apiVersion),
      nextCursor: nextCursor == null && nullToAbsent
          ? const Value.absent()
          : Value(nextCursor),
    );
  }

  factory JobFeedStateLocalData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return JobFeedStateLocalData(
      employeeId: serializer.fromJson<String>(json['employeeId']),
      rangeStart: serializer.fromJson<DateTime?>(json['rangeStart']),
      rangeEnd: serializer.fromJson<DateTime?>(json['rangeEnd']),
      lastRefreshed: serializer.fromJson<DateTime>(json['lastRefreshed']),
      apiVersion: serializer.fromJson<String?>(json['apiVersion']),
      nextCursor: serializer.fromJson<String?>(json['nextCursor']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'employeeId': serializer.toJson<String>(employeeId),
      'rangeStart': serializer.toJson<DateTime?>(rangeStart),
      'rangeEnd': serializer.toJson<DateTime?>(rangeEnd),
      'lastRefreshed': serializer.toJson<DateTime>(lastRefreshed),
      'apiVersion': serializer.toJson<String?>(apiVersion),
      'nextCursor': serializer.toJson<String?>(nextCursor),
    };
  }

  JobFeedStateLocalData copyWith(
          {String? employeeId,
          Value<DateTime?> rangeStart = const Value.absent(),
          Value<DateTime?> rangeEnd = const Value.absent(),
          DateTime? lastRefreshed,
          Value<String?> apiVersion = const Value.absent(),
          Value<String?> nextCursor = const Value.absent()}) =>
      JobFeedStateLocalData(
        employeeId: employeeId ?? this.employeeId,
        rangeStart: rangeStart.present ? rangeStart.value : this.rangeStart,
        rangeEnd: rangeEnd.present ? rangeEnd.value : this.rangeEnd,
        lastRefreshed: lastRefreshed ?? this.lastRefreshed,
        apiVersion: apiVersion.present ? apiVersion.value : this.apiVersion,
        nextCursor: nextCursor.present ? nextCursor.value : this.nextCursor,
      );
  JobFeedStateLocalData copyWithCompanion(JobFeedStateLocalCompanion data) {
    return JobFeedStateLocalData(
      employeeId:
          data.employeeId.present ? data.employeeId.value : this.employeeId,
      rangeStart:
          data.rangeStart.present ? data.rangeStart.value : this.rangeStart,
      rangeEnd: data.rangeEnd.present ? data.rangeEnd.value : this.rangeEnd,
      lastRefreshed: data.lastRefreshed.present
          ? data.lastRefreshed.value
          : this.lastRefreshed,
      apiVersion:
          data.apiVersion.present ? data.apiVersion.value : this.apiVersion,
      nextCursor:
          data.nextCursor.present ? data.nextCursor.value : this.nextCursor,
    );
  }

  @override
  String toString() {
    return (StringBuffer('JobFeedStateLocalData(')
          ..write('employeeId: $employeeId, ')
          ..write('rangeStart: $rangeStart, ')
          ..write('rangeEnd: $rangeEnd, ')
          ..write('lastRefreshed: $lastRefreshed, ')
          ..write('apiVersion: $apiVersion, ')
          ..write('nextCursor: $nextCursor')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      employeeId, rangeStart, rangeEnd, lastRefreshed, apiVersion, nextCursor);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is JobFeedStateLocalData &&
          other.employeeId == this.employeeId &&
          other.rangeStart == this.rangeStart &&
          other.rangeEnd == this.rangeEnd &&
          other.lastRefreshed == this.lastRefreshed &&
          other.apiVersion == this.apiVersion &&
          other.nextCursor == this.nextCursor);
}

class JobFeedStateLocalCompanion
    extends UpdateCompanion<JobFeedStateLocalData> {
  final Value<String> employeeId;
  final Value<DateTime?> rangeStart;
  final Value<DateTime?> rangeEnd;
  final Value<DateTime> lastRefreshed;
  final Value<String?> apiVersion;
  final Value<String?> nextCursor;
  final Value<int> rowid;
  const JobFeedStateLocalCompanion({
    this.employeeId = const Value.absent(),
    this.rangeStart = const Value.absent(),
    this.rangeEnd = const Value.absent(),
    this.lastRefreshed = const Value.absent(),
    this.apiVersion = const Value.absent(),
    this.nextCursor = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  JobFeedStateLocalCompanion.insert({
    required String employeeId,
    this.rangeStart = const Value.absent(),
    this.rangeEnd = const Value.absent(),
    this.lastRefreshed = const Value.absent(),
    this.apiVersion = const Value.absent(),
    this.nextCursor = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : employeeId = Value(employeeId);
  static Insertable<JobFeedStateLocalData> custom({
    Expression<String>? employeeId,
    Expression<DateTime>? rangeStart,
    Expression<DateTime>? rangeEnd,
    Expression<DateTime>? lastRefreshed,
    Expression<String>? apiVersion,
    Expression<String>? nextCursor,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (employeeId != null) 'employee_id': employeeId,
      if (rangeStart != null) 'range_start': rangeStart,
      if (rangeEnd != null) 'range_end': rangeEnd,
      if (lastRefreshed != null) 'last_refreshed': lastRefreshed,
      if (apiVersion != null) 'api_version': apiVersion,
      if (nextCursor != null) 'next_cursor': nextCursor,
      if (rowid != null) 'rowid': rowid,
    });
  }

  JobFeedStateLocalCompanion copyWith(
      {Value<String>? employeeId,
      Value<DateTime?>? rangeStart,
      Value<DateTime?>? rangeEnd,
      Value<DateTime>? lastRefreshed,
      Value<String?>? apiVersion,
      Value<String?>? nextCursor,
      Value<int>? rowid}) {
    return JobFeedStateLocalCompanion(
      employeeId: employeeId ?? this.employeeId,
      rangeStart: rangeStart ?? this.rangeStart,
      rangeEnd: rangeEnd ?? this.rangeEnd,
      lastRefreshed: lastRefreshed ?? this.lastRefreshed,
      apiVersion: apiVersion ?? this.apiVersion,
      nextCursor: nextCursor ?? this.nextCursor,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (employeeId.present) {
      map['employee_id'] = Variable<String>(employeeId.value);
    }
    if (rangeStart.present) {
      map['range_start'] = Variable<DateTime>(rangeStart.value);
    }
    if (rangeEnd.present) {
      map['range_end'] = Variable<DateTime>(rangeEnd.value);
    }
    if (lastRefreshed.present) {
      map['last_refreshed'] = Variable<DateTime>(lastRefreshed.value);
    }
    if (apiVersion.present) {
      map['api_version'] = Variable<String>(apiVersion.value);
    }
    if (nextCursor.present) {
      map['next_cursor'] = Variable<String>(nextCursor.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('JobFeedStateLocalCompanion(')
          ..write('employeeId: $employeeId, ')
          ..write('rangeStart: $rangeStart, ')
          ..write('rangeEnd: $rangeEnd, ')
          ..write('lastRefreshed: $lastRefreshed, ')
          ..write('apiVersion: $apiVersion, ')
          ..write('nextCursor: $nextCursor, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProfileLocalTable extends ProfileLocal
    with TableInfo<$ProfileLocalTable, ProfileLocalData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProfileLocalTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _employeeIdMeta =
      const VerificationMeta('employeeId');
  @override
  late final GeneratedColumn<String> employeeId = GeneratedColumn<String>(
      'employee_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _displayNameMeta =
      const VerificationMeta('displayName');
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
      'display_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
      'phone', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _crewMeta = const VerificationMeta('crew');
  @override
  late final GeneratedColumn<String> crew = GeneratedColumn<String>(
      'crew', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
      'role', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _deviceIdMeta =
      const VerificationMeta('deviceId');
  @override
  late final GeneratedColumn<String> deviceId = GeneratedColumn<String>(
      'device_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _osVersionMeta =
      const VerificationMeta('osVersion');
  @override
  late final GeneratedColumn<String> osVersion = GeneratedColumn<String>(
      'os_version', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _lastSyncMeta =
      const VerificationMeta('lastSync');
  @override
  late final GeneratedColumn<DateTime> lastSync = GeneratedColumn<DateTime>(
      'last_sync', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        employeeId,
        displayName,
        email,
        phone,
        crew,
        role,
        deviceId,
        osVersion,
        lastSync
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'profile_local';
  @override
  VerificationContext validateIntegrity(Insertable<ProfileLocalData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('employee_id')) {
      context.handle(
          _employeeIdMeta,
          employeeId.isAcceptableOrUnknown(
              data['employee_id']!, _employeeIdMeta));
    } else if (isInserting) {
      context.missing(_employeeIdMeta);
    }
    if (data.containsKey('display_name')) {
      context.handle(
          _displayNameMeta,
          displayName.isAcceptableOrUnknown(
              data['display_name']!, _displayNameMeta));
    } else if (isInserting) {
      context.missing(_displayNameMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    }
    if (data.containsKey('phone')) {
      context.handle(
          _phoneMeta, phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta));
    }
    if (data.containsKey('crew')) {
      context.handle(
          _crewMeta, crew.isAcceptableOrUnknown(data['crew']!, _crewMeta));
    }
    if (data.containsKey('role')) {
      context.handle(
          _roleMeta, role.isAcceptableOrUnknown(data['role']!, _roleMeta));
    }
    if (data.containsKey('device_id')) {
      context.handle(_deviceIdMeta,
          deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta));
    }
    if (data.containsKey('os_version')) {
      context.handle(_osVersionMeta,
          osVersion.isAcceptableOrUnknown(data['os_version']!, _osVersionMeta));
    }
    if (data.containsKey('last_sync')) {
      context.handle(_lastSyncMeta,
          lastSync.isAcceptableOrUnknown(data['last_sync']!, _lastSyncMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {employeeId};
  @override
  ProfileLocalData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProfileLocalData(
      employeeId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}employee_id'])!,
      displayName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}display_name'])!,
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email']),
      phone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phone']),
      crew: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}crew']),
      role: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}role']),
      deviceId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}device_id']),
      osVersion: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}os_version']),
      lastSync: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_sync']),
    );
  }

  @override
  $ProfileLocalTable createAlias(String alias) {
    return $ProfileLocalTable(attachedDatabase, alias);
  }
}

class ProfileLocalData extends DataClass
    implements Insertable<ProfileLocalData> {
  final String employeeId;
  final String displayName;
  final String? email;
  final String? phone;
  final String? crew;
  final String? role;
  final String? deviceId;
  final String? osVersion;
  final DateTime? lastSync;
  const ProfileLocalData(
      {required this.employeeId,
      required this.displayName,
      this.email,
      this.phone,
      this.crew,
      this.role,
      this.deviceId,
      this.osVersion,
      this.lastSync});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['employee_id'] = Variable<String>(employeeId);
    map['display_name'] = Variable<String>(displayName);
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || crew != null) {
      map['crew'] = Variable<String>(crew);
    }
    if (!nullToAbsent || role != null) {
      map['role'] = Variable<String>(role);
    }
    if (!nullToAbsent || deviceId != null) {
      map['device_id'] = Variable<String>(deviceId);
    }
    if (!nullToAbsent || osVersion != null) {
      map['os_version'] = Variable<String>(osVersion);
    }
    if (!nullToAbsent || lastSync != null) {
      map['last_sync'] = Variable<DateTime>(lastSync);
    }
    return map;
  }

  ProfileLocalCompanion toCompanion(bool nullToAbsent) {
    return ProfileLocalCompanion(
      employeeId: Value(employeeId),
      displayName: Value(displayName),
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
      phone:
          phone == null && nullToAbsent ? const Value.absent() : Value(phone),
      crew: crew == null && nullToAbsent ? const Value.absent() : Value(crew),
      role: role == null && nullToAbsent ? const Value.absent() : Value(role),
      deviceId: deviceId == null && nullToAbsent
          ? const Value.absent()
          : Value(deviceId),
      osVersion: osVersion == null && nullToAbsent
          ? const Value.absent()
          : Value(osVersion),
      lastSync: lastSync == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSync),
    );
  }

  factory ProfileLocalData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProfileLocalData(
      employeeId: serializer.fromJson<String>(json['employeeId']),
      displayName: serializer.fromJson<String>(json['displayName']),
      email: serializer.fromJson<String?>(json['email']),
      phone: serializer.fromJson<String?>(json['phone']),
      crew: serializer.fromJson<String?>(json['crew']),
      role: serializer.fromJson<String?>(json['role']),
      deviceId: serializer.fromJson<String?>(json['deviceId']),
      osVersion: serializer.fromJson<String?>(json['osVersion']),
      lastSync: serializer.fromJson<DateTime?>(json['lastSync']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'employeeId': serializer.toJson<String>(employeeId),
      'displayName': serializer.toJson<String>(displayName),
      'email': serializer.toJson<String?>(email),
      'phone': serializer.toJson<String?>(phone),
      'crew': serializer.toJson<String?>(crew),
      'role': serializer.toJson<String?>(role),
      'deviceId': serializer.toJson<String?>(deviceId),
      'osVersion': serializer.toJson<String?>(osVersion),
      'lastSync': serializer.toJson<DateTime?>(lastSync),
    };
  }

  ProfileLocalData copyWith(
          {String? employeeId,
          String? displayName,
          Value<String?> email = const Value.absent(),
          Value<String?> phone = const Value.absent(),
          Value<String?> crew = const Value.absent(),
          Value<String?> role = const Value.absent(),
          Value<String?> deviceId = const Value.absent(),
          Value<String?> osVersion = const Value.absent(),
          Value<DateTime?> lastSync = const Value.absent()}) =>
      ProfileLocalData(
        employeeId: employeeId ?? this.employeeId,
        displayName: displayName ?? this.displayName,
        email: email.present ? email.value : this.email,
        phone: phone.present ? phone.value : this.phone,
        crew: crew.present ? crew.value : this.crew,
        role: role.present ? role.value : this.role,
        deviceId: deviceId.present ? deviceId.value : this.deviceId,
        osVersion: osVersion.present ? osVersion.value : this.osVersion,
        lastSync: lastSync.present ? lastSync.value : this.lastSync,
      );
  ProfileLocalData copyWithCompanion(ProfileLocalCompanion data) {
    return ProfileLocalData(
      employeeId:
          data.employeeId.present ? data.employeeId.value : this.employeeId,
      displayName:
          data.displayName.present ? data.displayName.value : this.displayName,
      email: data.email.present ? data.email.value : this.email,
      phone: data.phone.present ? data.phone.value : this.phone,
      crew: data.crew.present ? data.crew.value : this.crew,
      role: data.role.present ? data.role.value : this.role,
      deviceId: data.deviceId.present ? data.deviceId.value : this.deviceId,
      osVersion: data.osVersion.present ? data.osVersion.value : this.osVersion,
      lastSync: data.lastSync.present ? data.lastSync.value : this.lastSync,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProfileLocalData(')
          ..write('employeeId: $employeeId, ')
          ..write('displayName: $displayName, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('crew: $crew, ')
          ..write('role: $role, ')
          ..write('deviceId: $deviceId, ')
          ..write('osVersion: $osVersion, ')
          ..write('lastSync: $lastSync')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(employeeId, displayName, email, phone, crew,
      role, deviceId, osVersion, lastSync);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProfileLocalData &&
          other.employeeId == this.employeeId &&
          other.displayName == this.displayName &&
          other.email == this.email &&
          other.phone == this.phone &&
          other.crew == this.crew &&
          other.role == this.role &&
          other.deviceId == this.deviceId &&
          other.osVersion == this.osVersion &&
          other.lastSync == this.lastSync);
}

class ProfileLocalCompanion extends UpdateCompanion<ProfileLocalData> {
  final Value<String> employeeId;
  final Value<String> displayName;
  final Value<String?> email;
  final Value<String?> phone;
  final Value<String?> crew;
  final Value<String?> role;
  final Value<String?> deviceId;
  final Value<String?> osVersion;
  final Value<DateTime?> lastSync;
  final Value<int> rowid;
  const ProfileLocalCompanion({
    this.employeeId = const Value.absent(),
    this.displayName = const Value.absent(),
    this.email = const Value.absent(),
    this.phone = const Value.absent(),
    this.crew = const Value.absent(),
    this.role = const Value.absent(),
    this.deviceId = const Value.absent(),
    this.osVersion = const Value.absent(),
    this.lastSync = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProfileLocalCompanion.insert({
    required String employeeId,
    required String displayName,
    this.email = const Value.absent(),
    this.phone = const Value.absent(),
    this.crew = const Value.absent(),
    this.role = const Value.absent(),
    this.deviceId = const Value.absent(),
    this.osVersion = const Value.absent(),
    this.lastSync = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : employeeId = Value(employeeId),
        displayName = Value(displayName);
  static Insertable<ProfileLocalData> custom({
    Expression<String>? employeeId,
    Expression<String>? displayName,
    Expression<String>? email,
    Expression<String>? phone,
    Expression<String>? crew,
    Expression<String>? role,
    Expression<String>? deviceId,
    Expression<String>? osVersion,
    Expression<DateTime>? lastSync,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (employeeId != null) 'employee_id': employeeId,
      if (displayName != null) 'display_name': displayName,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      if (crew != null) 'crew': crew,
      if (role != null) 'role': role,
      if (deviceId != null) 'device_id': deviceId,
      if (osVersion != null) 'os_version': osVersion,
      if (lastSync != null) 'last_sync': lastSync,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProfileLocalCompanion copyWith(
      {Value<String>? employeeId,
      Value<String>? displayName,
      Value<String?>? email,
      Value<String?>? phone,
      Value<String?>? crew,
      Value<String?>? role,
      Value<String?>? deviceId,
      Value<String?>? osVersion,
      Value<DateTime?>? lastSync,
      Value<int>? rowid}) {
    return ProfileLocalCompanion(
      employeeId: employeeId ?? this.employeeId,
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      crew: crew ?? this.crew,
      role: role ?? this.role,
      deviceId: deviceId ?? this.deviceId,
      osVersion: osVersion ?? this.osVersion,
      lastSync: lastSync ?? this.lastSync,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (employeeId.present) {
      map['employee_id'] = Variable<String>(employeeId.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (crew.present) {
      map['crew'] = Variable<String>(crew.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (deviceId.present) {
      map['device_id'] = Variable<String>(deviceId.value);
    }
    if (osVersion.present) {
      map['os_version'] = Variable<String>(osVersion.value);
    }
    if (lastSync.present) {
      map['last_sync'] = Variable<DateTime>(lastSync.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProfileLocalCompanion(')
          ..write('employeeId: $employeeId, ')
          ..write('displayName: $displayName, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('crew: $crew, ')
          ..write('role: $role, ')
          ..write('deviceId: $deviceId, ')
          ..write('osVersion: $osVersion, ')
          ..write('lastSync: $lastSync, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SyncQueueTable extends SyncQueue
    with TableInfo<$SyncQueueTable, SyncQueueData> {
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
  static const VerificationMeta _entityTypeMeta =
      const VerificationMeta('entityType');
  @override
  late final GeneratedColumn<String> entityType = GeneratedColumn<String>(
      'entity_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _payloadMeta =
      const VerificationMeta('payload');
  @override
  late final GeneratedColumn<String> payload = GeneratedColumn<String>(
      'payload', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
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
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _lastAttemptAtMeta =
      const VerificationMeta('lastAttemptAt');
  @override
  late final GeneratedColumn<DateTime> lastAttemptAt =
      GeneratedColumn<DateTime>('last_attempt_at', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _mobileUuidMeta =
      const VerificationMeta('mobileUuid');
  @override
  late final GeneratedColumn<String> mobileUuid = GeneratedColumn<String>(
      'mobile_uuid', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        entityType,
        payload,
        attemptCount,
        lastError,
        createdAt,
        lastAttemptAt,
        mobileUuid
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_queue';
  @override
  VerificationContext validateIntegrity(Insertable<SyncQueueData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('entity_type')) {
      context.handle(
          _entityTypeMeta,
          entityType.isAcceptableOrUnknown(
              data['entity_type']!, _entityTypeMeta));
    } else if (isInserting) {
      context.missing(_entityTypeMeta);
    }
    if (data.containsKey('payload')) {
      context.handle(_payloadMeta,
          payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta));
    } else if (isInserting) {
      context.missing(_payloadMeta);
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
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('last_attempt_at')) {
      context.handle(
          _lastAttemptAtMeta,
          lastAttemptAt.isAcceptableOrUnknown(
              data['last_attempt_at']!, _lastAttemptAtMeta));
    }
    if (data.containsKey('mobile_uuid')) {
      context.handle(
          _mobileUuidMeta,
          mobileUuid.isAcceptableOrUnknown(
              data['mobile_uuid']!, _mobileUuidMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
        {entityType, mobileUuid},
      ];
  @override
  SyncQueueData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncQueueData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      entityType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}entity_type'])!,
      payload: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}payload'])!,
      attemptCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}attempt_count'])!,
      lastError: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}last_error']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      lastAttemptAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}last_attempt_at']),
      mobileUuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}mobile_uuid']),
    );
  }

  @override
  $SyncQueueTable createAlias(String alias) {
    return $SyncQueueTable(attachedDatabase, alias);
  }
}

class SyncQueueData extends DataClass implements Insertable<SyncQueueData> {
  final int id;
  final String entityType;
  final String payload;
  final int attemptCount;
  final String? lastError;
  final DateTime createdAt;
  final DateTime? lastAttemptAt;
  final String? mobileUuid;
  const SyncQueueData(
      {required this.id,
      required this.entityType,
      required this.payload,
      required this.attemptCount,
      this.lastError,
      required this.createdAt,
      this.lastAttemptAt,
      this.mobileUuid});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['entity_type'] = Variable<String>(entityType);
    map['payload'] = Variable<String>(payload);
    map['attempt_count'] = Variable<int>(attemptCount);
    if (!nullToAbsent || lastError != null) {
      map['last_error'] = Variable<String>(lastError);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || lastAttemptAt != null) {
      map['last_attempt_at'] = Variable<DateTime>(lastAttemptAt);
    }
    if (!nullToAbsent || mobileUuid != null) {
      map['mobile_uuid'] = Variable<String>(mobileUuid);
    }
    return map;
  }

  SyncQueueCompanion toCompanion(bool nullToAbsent) {
    return SyncQueueCompanion(
      id: Value(id),
      entityType: Value(entityType),
      payload: Value(payload),
      attemptCount: Value(attemptCount),
      lastError: lastError == null && nullToAbsent
          ? const Value.absent()
          : Value(lastError),
      createdAt: Value(createdAt),
      lastAttemptAt: lastAttemptAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastAttemptAt),
      mobileUuid: mobileUuid == null && nullToAbsent
          ? const Value.absent()
          : Value(mobileUuid),
    );
  }

  factory SyncQueueData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncQueueData(
      id: serializer.fromJson<int>(json['id']),
      entityType: serializer.fromJson<String>(json['entityType']),
      payload: serializer.fromJson<String>(json['payload']),
      attemptCount: serializer.fromJson<int>(json['attemptCount']),
      lastError: serializer.fromJson<String?>(json['lastError']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      lastAttemptAt: serializer.fromJson<DateTime?>(json['lastAttemptAt']),
      mobileUuid: serializer.fromJson<String?>(json['mobileUuid']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'entityType': serializer.toJson<String>(entityType),
      'payload': serializer.toJson<String>(payload),
      'attemptCount': serializer.toJson<int>(attemptCount),
      'lastError': serializer.toJson<String?>(lastError),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'lastAttemptAt': serializer.toJson<DateTime?>(lastAttemptAt),
      'mobileUuid': serializer.toJson<String?>(mobileUuid),
    };
  }

  SyncQueueData copyWith(
          {int? id,
          String? entityType,
          String? payload,
          int? attemptCount,
          Value<String?> lastError = const Value.absent(),
          DateTime? createdAt,
          Value<DateTime?> lastAttemptAt = const Value.absent(),
          Value<String?> mobileUuid = const Value.absent()}) =>
      SyncQueueData(
        id: id ?? this.id,
        entityType: entityType ?? this.entityType,
        payload: payload ?? this.payload,
        attemptCount: attemptCount ?? this.attemptCount,
        lastError: lastError.present ? lastError.value : this.lastError,
        createdAt: createdAt ?? this.createdAt,
        lastAttemptAt:
            lastAttemptAt.present ? lastAttemptAt.value : this.lastAttemptAt,
        mobileUuid: mobileUuid.present ? mobileUuid.value : this.mobileUuid,
      );
  SyncQueueData copyWithCompanion(SyncQueueCompanion data) {
    return SyncQueueData(
      id: data.id.present ? data.id.value : this.id,
      entityType:
          data.entityType.present ? data.entityType.value : this.entityType,
      payload: data.payload.present ? data.payload.value : this.payload,
      attemptCount: data.attemptCount.present
          ? data.attemptCount.value
          : this.attemptCount,
      lastError: data.lastError.present ? data.lastError.value : this.lastError,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      lastAttemptAt: data.lastAttemptAt.present
          ? data.lastAttemptAt.value
          : this.lastAttemptAt,
      mobileUuid:
          data.mobileUuid.present ? data.mobileUuid.value : this.mobileUuid,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueData(')
          ..write('id: $id, ')
          ..write('entityType: $entityType, ')
          ..write('payload: $payload, ')
          ..write('attemptCount: $attemptCount, ')
          ..write('lastError: $lastError, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastAttemptAt: $lastAttemptAt, ')
          ..write('mobileUuid: $mobileUuid')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, entityType, payload, attemptCount,
      lastError, createdAt, lastAttemptAt, mobileUuid);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncQueueData &&
          other.id == this.id &&
          other.entityType == this.entityType &&
          other.payload == this.payload &&
          other.attemptCount == this.attemptCount &&
          other.lastError == this.lastError &&
          other.createdAt == this.createdAt &&
          other.lastAttemptAt == this.lastAttemptAt &&
          other.mobileUuid == this.mobileUuid);
}

class SyncQueueCompanion extends UpdateCompanion<SyncQueueData> {
  final Value<int> id;
  final Value<String> entityType;
  final Value<String> payload;
  final Value<int> attemptCount;
  final Value<String?> lastError;
  final Value<DateTime> createdAt;
  final Value<DateTime?> lastAttemptAt;
  final Value<String?> mobileUuid;
  const SyncQueueCompanion({
    this.id = const Value.absent(),
    this.entityType = const Value.absent(),
    this.payload = const Value.absent(),
    this.attemptCount = const Value.absent(),
    this.lastError = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.lastAttemptAt = const Value.absent(),
    this.mobileUuid = const Value.absent(),
  });
  SyncQueueCompanion.insert({
    this.id = const Value.absent(),
    required String entityType,
    required String payload,
    this.attemptCount = const Value.absent(),
    this.lastError = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.lastAttemptAt = const Value.absent(),
    this.mobileUuid = const Value.absent(),
  })  : entityType = Value(entityType),
        payload = Value(payload);
  static Insertable<SyncQueueData> custom({
    Expression<int>? id,
    Expression<String>? entityType,
    Expression<String>? payload,
    Expression<int>? attemptCount,
    Expression<String>? lastError,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? lastAttemptAt,
    Expression<String>? mobileUuid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (entityType != null) 'entity_type': entityType,
      if (payload != null) 'payload': payload,
      if (attemptCount != null) 'attempt_count': attemptCount,
      if (lastError != null) 'last_error': lastError,
      if (createdAt != null) 'created_at': createdAt,
      if (lastAttemptAt != null) 'last_attempt_at': lastAttemptAt,
      if (mobileUuid != null) 'mobile_uuid': mobileUuid,
    });
  }

  SyncQueueCompanion copyWith(
      {Value<int>? id,
      Value<String>? entityType,
      Value<String>? payload,
      Value<int>? attemptCount,
      Value<String?>? lastError,
      Value<DateTime>? createdAt,
      Value<DateTime?>? lastAttemptAt,
      Value<String?>? mobileUuid}) {
    return SyncQueueCompanion(
      id: id ?? this.id,
      entityType: entityType ?? this.entityType,
      payload: payload ?? this.payload,
      attemptCount: attemptCount ?? this.attemptCount,
      lastError: lastError ?? this.lastError,
      createdAt: createdAt ?? this.createdAt,
      lastAttemptAt: lastAttemptAt ?? this.lastAttemptAt,
      mobileUuid: mobileUuid ?? this.mobileUuid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (entityType.present) {
      map['entity_type'] = Variable<String>(entityType.value);
    }
    if (payload.present) {
      map['payload'] = Variable<String>(payload.value);
    }
    if (attemptCount.present) {
      map['attempt_count'] = Variable<int>(attemptCount.value);
    }
    if (lastError.present) {
      map['last_error'] = Variable<String>(lastError.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (lastAttemptAt.present) {
      map['last_attempt_at'] = Variable<DateTime>(lastAttemptAt.value);
    }
    if (mobileUuid.present) {
      map['mobile_uuid'] = Variable<String>(mobileUuid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueCompanion(')
          ..write('id: $id, ')
          ..write('entityType: $entityType, ')
          ..write('payload: $payload, ')
          ..write('attemptCount: $attemptCount, ')
          ..write('lastError: $lastError, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastAttemptAt: $lastAttemptAt, ')
          ..write('mobileUuid: $mobileUuid')
          ..write(')'))
        .toString();
  }
}

class $CorruptQueueEntriesTable extends CorruptQueueEntries
    with TableInfo<$CorruptQueueEntriesTable, CorruptQueueEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CorruptQueueEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _originalQueueIdMeta =
      const VerificationMeta('originalQueueId');
  @override
  late final GeneratedColumn<int> originalQueueId = GeneratedColumn<int>(
      'original_queue_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _entityTypeMeta =
      const VerificationMeta('entityType');
  @override
  late final GeneratedColumn<String> entityType = GeneratedColumn<String>(
      'entity_type', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _payloadMeta =
      const VerificationMeta('payload');
  @override
  late final GeneratedColumn<String> payload = GeneratedColumn<String>(
      'payload', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _errorMeta = const VerificationMeta('error');
  @override
  late final GeneratedColumn<String> error = GeneratedColumn<String>(
      'error', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, originalQueueId, entityType, payload, error, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'corrupt_queue_entries';
  @override
  VerificationContext validateIntegrity(Insertable<CorruptQueueEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('original_queue_id')) {
      context.handle(
          _originalQueueIdMeta,
          originalQueueId.isAcceptableOrUnknown(
              data['original_queue_id']!, _originalQueueIdMeta));
    }
    if (data.containsKey('entity_type')) {
      context.handle(
          _entityTypeMeta,
          entityType.isAcceptableOrUnknown(
              data['entity_type']!, _entityTypeMeta));
    }
    if (data.containsKey('payload')) {
      context.handle(_payloadMeta,
          payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta));
    }
    if (data.containsKey('error')) {
      context.handle(
          _errorMeta, error.isAcceptableOrUnknown(data['error']!, _errorMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CorruptQueueEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CorruptQueueEntry(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      originalQueueId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}original_queue_id']),
      entityType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}entity_type']),
      payload: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}payload']),
      error: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}error']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $CorruptQueueEntriesTable createAlias(String alias) {
    return $CorruptQueueEntriesTable(attachedDatabase, alias);
  }
}

class CorruptQueueEntry extends DataClass
    implements Insertable<CorruptQueueEntry> {
  final int id;
  final int? originalQueueId;
  final String? entityType;
  final String? payload;
  final String? error;
  final DateTime createdAt;
  const CorruptQueueEntry(
      {required this.id,
      this.originalQueueId,
      this.entityType,
      this.payload,
      this.error,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || originalQueueId != null) {
      map['original_queue_id'] = Variable<int>(originalQueueId);
    }
    if (!nullToAbsent || entityType != null) {
      map['entity_type'] = Variable<String>(entityType);
    }
    if (!nullToAbsent || payload != null) {
      map['payload'] = Variable<String>(payload);
    }
    if (!nullToAbsent || error != null) {
      map['error'] = Variable<String>(error);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  CorruptQueueEntriesCompanion toCompanion(bool nullToAbsent) {
    return CorruptQueueEntriesCompanion(
      id: Value(id),
      originalQueueId: originalQueueId == null && nullToAbsent
          ? const Value.absent()
          : Value(originalQueueId),
      entityType: entityType == null && nullToAbsent
          ? const Value.absent()
          : Value(entityType),
      payload: payload == null && nullToAbsent
          ? const Value.absent()
          : Value(payload),
      error:
          error == null && nullToAbsent ? const Value.absent() : Value(error),
      createdAt: Value(createdAt),
    );
  }

  factory CorruptQueueEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CorruptQueueEntry(
      id: serializer.fromJson<int>(json['id']),
      originalQueueId: serializer.fromJson<int?>(json['originalQueueId']),
      entityType: serializer.fromJson<String?>(json['entityType']),
      payload: serializer.fromJson<String?>(json['payload']),
      error: serializer.fromJson<String?>(json['error']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'originalQueueId': serializer.toJson<int?>(originalQueueId),
      'entityType': serializer.toJson<String?>(entityType),
      'payload': serializer.toJson<String?>(payload),
      'error': serializer.toJson<String?>(error),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  CorruptQueueEntry copyWith(
          {int? id,
          Value<int?> originalQueueId = const Value.absent(),
          Value<String?> entityType = const Value.absent(),
          Value<String?> payload = const Value.absent(),
          Value<String?> error = const Value.absent(),
          DateTime? createdAt}) =>
      CorruptQueueEntry(
        id: id ?? this.id,
        originalQueueId: originalQueueId.present
            ? originalQueueId.value
            : this.originalQueueId,
        entityType: entityType.present ? entityType.value : this.entityType,
        payload: payload.present ? payload.value : this.payload,
        error: error.present ? error.value : this.error,
        createdAt: createdAt ?? this.createdAt,
      );
  CorruptQueueEntry copyWithCompanion(CorruptQueueEntriesCompanion data) {
    return CorruptQueueEntry(
      id: data.id.present ? data.id.value : this.id,
      originalQueueId: data.originalQueueId.present
          ? data.originalQueueId.value
          : this.originalQueueId,
      entityType:
          data.entityType.present ? data.entityType.value : this.entityType,
      payload: data.payload.present ? data.payload.value : this.payload,
      error: data.error.present ? data.error.value : this.error,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CorruptQueueEntry(')
          ..write('id: $id, ')
          ..write('originalQueueId: $originalQueueId, ')
          ..write('entityType: $entityType, ')
          ..write('payload: $payload, ')
          ..write('error: $error, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, originalQueueId, entityType, payload, error, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CorruptQueueEntry &&
          other.id == this.id &&
          other.originalQueueId == this.originalQueueId &&
          other.entityType == this.entityType &&
          other.payload == this.payload &&
          other.error == this.error &&
          other.createdAt == this.createdAt);
}

class CorruptQueueEntriesCompanion extends UpdateCompanion<CorruptQueueEntry> {
  final Value<int> id;
  final Value<int?> originalQueueId;
  final Value<String?> entityType;
  final Value<String?> payload;
  final Value<String?> error;
  final Value<DateTime> createdAt;
  const CorruptQueueEntriesCompanion({
    this.id = const Value.absent(),
    this.originalQueueId = const Value.absent(),
    this.entityType = const Value.absent(),
    this.payload = const Value.absent(),
    this.error = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  CorruptQueueEntriesCompanion.insert({
    this.id = const Value.absent(),
    this.originalQueueId = const Value.absent(),
    this.entityType = const Value.absent(),
    this.payload = const Value.absent(),
    this.error = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  static Insertable<CorruptQueueEntry> custom({
    Expression<int>? id,
    Expression<int>? originalQueueId,
    Expression<String>? entityType,
    Expression<String>? payload,
    Expression<String>? error,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (originalQueueId != null) 'original_queue_id': originalQueueId,
      if (entityType != null) 'entity_type': entityType,
      if (payload != null) 'payload': payload,
      if (error != null) 'error': error,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  CorruptQueueEntriesCompanion copyWith(
      {Value<int>? id,
      Value<int?>? originalQueueId,
      Value<String?>? entityType,
      Value<String?>? payload,
      Value<String?>? error,
      Value<DateTime>? createdAt}) {
    return CorruptQueueEntriesCompanion(
      id: id ?? this.id,
      originalQueueId: originalQueueId ?? this.originalQueueId,
      entityType: entityType ?? this.entityType,
      payload: payload ?? this.payload,
      error: error ?? this.error,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (originalQueueId.present) {
      map['original_queue_id'] = Variable<int>(originalQueueId.value);
    }
    if (entityType.present) {
      map['entity_type'] = Variable<String>(entityType.value);
    }
    if (payload.present) {
      map['payload'] = Variable<String>(payload.value);
    }
    if (error.present) {
      map['error'] = Variable<String>(error.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CorruptQueueEntriesCompanion(')
          ..write('id: $id, ')
          ..write('originalQueueId: $originalQueueId, ')
          ..write('entityType: $entityType, ')
          ..write('payload: $payload, ')
          ..write('error: $error, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $TimesheetLocalTable extends TimesheetLocal
    with TableInfo<$TimesheetLocalTable, TimesheetLocalData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TimesheetLocalTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _timesheetIdMeta =
      const VerificationMeta('timesheetId');
  @override
  late final GeneratedColumn<String> timesheetId = GeneratedColumn<String>(
      'timesheet_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _employeeIdMeta =
      const VerificationMeta('employeeId');
  @override
  late final GeneratedColumn<String> employeeId = GeneratedColumn<String>(
      'employee_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _weekStartMeta =
      const VerificationMeta('weekStart');
  @override
  late final GeneratedColumn<DateTime> weekStart = GeneratedColumn<DateTime>(
      'week_start', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _weekEndMeta =
      const VerificationMeta('weekEnd');
  @override
  late final GeneratedColumn<DateTime> weekEnd = GeneratedColumn<DateTime>(
      'week_end', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _regularHoursMeta =
      const VerificationMeta('regularHours');
  @override
  late final GeneratedColumn<double> regularHours = GeneratedColumn<double>(
      'regular_hours', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _otHoursMeta =
      const VerificationMeta('otHours');
  @override
  late final GeneratedColumn<double> otHours = GeneratedColumn<double>(
      'ot_hours', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _weeklyTotalHoursMeta =
      const VerificationMeta('weeklyTotalHours');
  @override
  late final GeneratedColumn<double> weeklyTotalHours = GeneratedColumn<double>(
      'weekly_total_hours', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _weeklyOt1HoursMeta =
      const VerificationMeta('weeklyOt1Hours');
  @override
  late final GeneratedColumn<double> weeklyOt1Hours = GeneratedColumn<double>(
      'weekly_ot1_hours', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _estimatedPayMeta =
      const VerificationMeta('estimatedPay');
  @override
  late final GeneratedColumn<double> estimatedPay = GeneratedColumn<double>(
      'estimated_pay', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _syncedMeta = const VerificationMeta('synced');
  @override
  late final GeneratedColumn<bool> synced = GeneratedColumn<bool>(
      'synced', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("synced" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _adjustedMeta =
      const VerificationMeta('adjusted');
  @override
  late final GeneratedColumn<bool> adjusted = GeneratedColumn<bool>(
      'adjusted', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("adjusted" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _flaggedMeta =
      const VerificationMeta('flagged');
  @override
  late final GeneratedColumn<bool> flagged = GeneratedColumn<bool>(
      'flagged', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("flagged" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _disputeStatusMeta =
      const VerificationMeta('disputeStatus');
  @override
  late final GeneratedColumn<String> disputeStatus = GeneratedColumn<String>(
      'dispute_status', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        timesheetId,
        employeeId,
        weekStart,
        weekEnd,
        date,
        regularHours,
        otHours,
        notes,
        weeklyTotalHours,
        weeklyOt1Hours,
        estimatedPay,
        synced,
        adjusted,
        flagged,
        disputeStatus,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'timesheet_local';
  @override
  VerificationContext validateIntegrity(Insertable<TimesheetLocalData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('timesheet_id')) {
      context.handle(
          _timesheetIdMeta,
          timesheetId.isAcceptableOrUnknown(
              data['timesheet_id']!, _timesheetIdMeta));
    } else if (isInserting) {
      context.missing(_timesheetIdMeta);
    }
    if (data.containsKey('employee_id')) {
      context.handle(
          _employeeIdMeta,
          employeeId.isAcceptableOrUnknown(
              data['employee_id']!, _employeeIdMeta));
    } else if (isInserting) {
      context.missing(_employeeIdMeta);
    }
    if (data.containsKey('week_start')) {
      context.handle(_weekStartMeta,
          weekStart.isAcceptableOrUnknown(data['week_start']!, _weekStartMeta));
    } else if (isInserting) {
      context.missing(_weekStartMeta);
    }
    if (data.containsKey('week_end')) {
      context.handle(_weekEndMeta,
          weekEnd.isAcceptableOrUnknown(data['week_end']!, _weekEndMeta));
    } else if (isInserting) {
      context.missing(_weekEndMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('regular_hours')) {
      context.handle(
          _regularHoursMeta,
          regularHours.isAcceptableOrUnknown(
              data['regular_hours']!, _regularHoursMeta));
    } else if (isInserting) {
      context.missing(_regularHoursMeta);
    }
    if (data.containsKey('ot_hours')) {
      context.handle(_otHoursMeta,
          otHours.isAcceptableOrUnknown(data['ot_hours']!, _otHoursMeta));
    } else if (isInserting) {
      context.missing(_otHoursMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('weekly_total_hours')) {
      context.handle(
          _weeklyTotalHoursMeta,
          weeklyTotalHours.isAcceptableOrUnknown(
              data['weekly_total_hours']!, _weeklyTotalHoursMeta));
    } else if (isInserting) {
      context.missing(_weeklyTotalHoursMeta);
    }
    if (data.containsKey('weekly_ot1_hours')) {
      context.handle(
          _weeklyOt1HoursMeta,
          weeklyOt1Hours.isAcceptableOrUnknown(
              data['weekly_ot1_hours']!, _weeklyOt1HoursMeta));
    } else if (isInserting) {
      context.missing(_weeklyOt1HoursMeta);
    }
    if (data.containsKey('estimated_pay')) {
      context.handle(
          _estimatedPayMeta,
          estimatedPay.isAcceptableOrUnknown(
              data['estimated_pay']!, _estimatedPayMeta));
    } else if (isInserting) {
      context.missing(_estimatedPayMeta);
    }
    if (data.containsKey('synced')) {
      context.handle(_syncedMeta,
          synced.isAcceptableOrUnknown(data['synced']!, _syncedMeta));
    }
    if (data.containsKey('adjusted')) {
      context.handle(_adjustedMeta,
          adjusted.isAcceptableOrUnknown(data['adjusted']!, _adjustedMeta));
    }
    if (data.containsKey('flagged')) {
      context.handle(_flaggedMeta,
          flagged.isAcceptableOrUnknown(data['flagged']!, _flaggedMeta));
    }
    if (data.containsKey('dispute_status')) {
      context.handle(
          _disputeStatusMeta,
          disputeStatus.isAcceptableOrUnknown(
              data['dispute_status']!, _disputeStatusMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {timesheetId};
  @override
  TimesheetLocalData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TimesheetLocalData(
      timesheetId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}timesheet_id'])!,
      employeeId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}employee_id'])!,
      weekStart: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}week_start'])!,
      weekEnd: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}week_end'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      regularHours: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}regular_hours'])!,
      otHours: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}ot_hours'])!,
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      weeklyTotalHours: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}weekly_total_hours'])!,
      weeklyOt1Hours: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}weekly_ot1_hours'])!,
      estimatedPay: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}estimated_pay'])!,
      synced: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}synced'])!,
      adjusted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}adjusted'])!,
      flagged: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}flagged'])!,
      disputeStatus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}dispute_status']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $TimesheetLocalTable createAlias(String alias) {
    return $TimesheetLocalTable(attachedDatabase, alias);
  }
}

class TimesheetLocalData extends DataClass
    implements Insertable<TimesheetLocalData> {
  final String timesheetId;
  final String employeeId;
  final DateTime weekStart;
  final DateTime weekEnd;
  final DateTime date;
  final double regularHours;
  final double otHours;
  final String? notes;
  final double weeklyTotalHours;
  final double weeklyOt1Hours;
  final double estimatedPay;
  final bool synced;
  final bool adjusted;
  final bool flagged;
  final String? disputeStatus;
  final DateTime createdAt;
  final DateTime updatedAt;
  const TimesheetLocalData(
      {required this.timesheetId,
      required this.employeeId,
      required this.weekStart,
      required this.weekEnd,
      required this.date,
      required this.regularHours,
      required this.otHours,
      this.notes,
      required this.weeklyTotalHours,
      required this.weeklyOt1Hours,
      required this.estimatedPay,
      required this.synced,
      required this.adjusted,
      required this.flagged,
      this.disputeStatus,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['timesheet_id'] = Variable<String>(timesheetId);
    map['employee_id'] = Variable<String>(employeeId);
    map['week_start'] = Variable<DateTime>(weekStart);
    map['week_end'] = Variable<DateTime>(weekEnd);
    map['date'] = Variable<DateTime>(date);
    map['regular_hours'] = Variable<double>(regularHours);
    map['ot_hours'] = Variable<double>(otHours);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['weekly_total_hours'] = Variable<double>(weeklyTotalHours);
    map['weekly_ot1_hours'] = Variable<double>(weeklyOt1Hours);
    map['estimated_pay'] = Variable<double>(estimatedPay);
    map['synced'] = Variable<bool>(synced);
    map['adjusted'] = Variable<bool>(adjusted);
    map['flagged'] = Variable<bool>(flagged);
    if (!nullToAbsent || disputeStatus != null) {
      map['dispute_status'] = Variable<String>(disputeStatus);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  TimesheetLocalCompanion toCompanion(bool nullToAbsent) {
    return TimesheetLocalCompanion(
      timesheetId: Value(timesheetId),
      employeeId: Value(employeeId),
      weekStart: Value(weekStart),
      weekEnd: Value(weekEnd),
      date: Value(date),
      regularHours: Value(regularHours),
      otHours: Value(otHours),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      weeklyTotalHours: Value(weeklyTotalHours),
      weeklyOt1Hours: Value(weeklyOt1Hours),
      estimatedPay: Value(estimatedPay),
      synced: Value(synced),
      adjusted: Value(adjusted),
      flagged: Value(flagged),
      disputeStatus: disputeStatus == null && nullToAbsent
          ? const Value.absent()
          : Value(disputeStatus),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory TimesheetLocalData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TimesheetLocalData(
      timesheetId: serializer.fromJson<String>(json['timesheetId']),
      employeeId: serializer.fromJson<String>(json['employeeId']),
      weekStart: serializer.fromJson<DateTime>(json['weekStart']),
      weekEnd: serializer.fromJson<DateTime>(json['weekEnd']),
      date: serializer.fromJson<DateTime>(json['date']),
      regularHours: serializer.fromJson<double>(json['regularHours']),
      otHours: serializer.fromJson<double>(json['otHours']),
      notes: serializer.fromJson<String?>(json['notes']),
      weeklyTotalHours: serializer.fromJson<double>(json['weeklyTotalHours']),
      weeklyOt1Hours: serializer.fromJson<double>(json['weeklyOt1Hours']),
      estimatedPay: serializer.fromJson<double>(json['estimatedPay']),
      synced: serializer.fromJson<bool>(json['synced']),
      adjusted: serializer.fromJson<bool>(json['adjusted']),
      flagged: serializer.fromJson<bool>(json['flagged']),
      disputeStatus: serializer.fromJson<String?>(json['disputeStatus']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'timesheetId': serializer.toJson<String>(timesheetId),
      'employeeId': serializer.toJson<String>(employeeId),
      'weekStart': serializer.toJson<DateTime>(weekStart),
      'weekEnd': serializer.toJson<DateTime>(weekEnd),
      'date': serializer.toJson<DateTime>(date),
      'regularHours': serializer.toJson<double>(regularHours),
      'otHours': serializer.toJson<double>(otHours),
      'notes': serializer.toJson<String?>(notes),
      'weeklyTotalHours': serializer.toJson<double>(weeklyTotalHours),
      'weeklyOt1Hours': serializer.toJson<double>(weeklyOt1Hours),
      'estimatedPay': serializer.toJson<double>(estimatedPay),
      'synced': serializer.toJson<bool>(synced),
      'adjusted': serializer.toJson<bool>(adjusted),
      'flagged': serializer.toJson<bool>(flagged),
      'disputeStatus': serializer.toJson<String?>(disputeStatus),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  TimesheetLocalData copyWith(
          {String? timesheetId,
          String? employeeId,
          DateTime? weekStart,
          DateTime? weekEnd,
          DateTime? date,
          double? regularHours,
          double? otHours,
          Value<String?> notes = const Value.absent(),
          double? weeklyTotalHours,
          double? weeklyOt1Hours,
          double? estimatedPay,
          bool? synced,
          bool? adjusted,
          bool? flagged,
          Value<String?> disputeStatus = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      TimesheetLocalData(
        timesheetId: timesheetId ?? this.timesheetId,
        employeeId: employeeId ?? this.employeeId,
        weekStart: weekStart ?? this.weekStart,
        weekEnd: weekEnd ?? this.weekEnd,
        date: date ?? this.date,
        regularHours: regularHours ?? this.regularHours,
        otHours: otHours ?? this.otHours,
        notes: notes.present ? notes.value : this.notes,
        weeklyTotalHours: weeklyTotalHours ?? this.weeklyTotalHours,
        weeklyOt1Hours: weeklyOt1Hours ?? this.weeklyOt1Hours,
        estimatedPay: estimatedPay ?? this.estimatedPay,
        synced: synced ?? this.synced,
        adjusted: adjusted ?? this.adjusted,
        flagged: flagged ?? this.flagged,
        disputeStatus:
            disputeStatus.present ? disputeStatus.value : this.disputeStatus,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  TimesheetLocalData copyWithCompanion(TimesheetLocalCompanion data) {
    return TimesheetLocalData(
      timesheetId:
          data.timesheetId.present ? data.timesheetId.value : this.timesheetId,
      employeeId:
          data.employeeId.present ? data.employeeId.value : this.employeeId,
      weekStart: data.weekStart.present ? data.weekStart.value : this.weekStart,
      weekEnd: data.weekEnd.present ? data.weekEnd.value : this.weekEnd,
      date: data.date.present ? data.date.value : this.date,
      regularHours: data.regularHours.present
          ? data.regularHours.value
          : this.regularHours,
      otHours: data.otHours.present ? data.otHours.value : this.otHours,
      notes: data.notes.present ? data.notes.value : this.notes,
      weeklyTotalHours: data.weeklyTotalHours.present
          ? data.weeklyTotalHours.value
          : this.weeklyTotalHours,
      weeklyOt1Hours: data.weeklyOt1Hours.present
          ? data.weeklyOt1Hours.value
          : this.weeklyOt1Hours,
      estimatedPay: data.estimatedPay.present
          ? data.estimatedPay.value
          : this.estimatedPay,
      synced: data.synced.present ? data.synced.value : this.synced,
      adjusted: data.adjusted.present ? data.adjusted.value : this.adjusted,
      flagged: data.flagged.present ? data.flagged.value : this.flagged,
      disputeStatus: data.disputeStatus.present
          ? data.disputeStatus.value
          : this.disputeStatus,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TimesheetLocalData(')
          ..write('timesheetId: $timesheetId, ')
          ..write('employeeId: $employeeId, ')
          ..write('weekStart: $weekStart, ')
          ..write('weekEnd: $weekEnd, ')
          ..write('date: $date, ')
          ..write('regularHours: $regularHours, ')
          ..write('otHours: $otHours, ')
          ..write('notes: $notes, ')
          ..write('weeklyTotalHours: $weeklyTotalHours, ')
          ..write('weeklyOt1Hours: $weeklyOt1Hours, ')
          ..write('estimatedPay: $estimatedPay, ')
          ..write('synced: $synced, ')
          ..write('adjusted: $adjusted, ')
          ..write('flagged: $flagged, ')
          ..write('disputeStatus: $disputeStatus, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      timesheetId,
      employeeId,
      weekStart,
      weekEnd,
      date,
      regularHours,
      otHours,
      notes,
      weeklyTotalHours,
      weeklyOt1Hours,
      estimatedPay,
      synced,
      adjusted,
      flagged,
      disputeStatus,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TimesheetLocalData &&
          other.timesheetId == this.timesheetId &&
          other.employeeId == this.employeeId &&
          other.weekStart == this.weekStart &&
          other.weekEnd == this.weekEnd &&
          other.date == this.date &&
          other.regularHours == this.regularHours &&
          other.otHours == this.otHours &&
          other.notes == this.notes &&
          other.weeklyTotalHours == this.weeklyTotalHours &&
          other.weeklyOt1Hours == this.weeklyOt1Hours &&
          other.estimatedPay == this.estimatedPay &&
          other.synced == this.synced &&
          other.adjusted == this.adjusted &&
          other.flagged == this.flagged &&
          other.disputeStatus == this.disputeStatus &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class TimesheetLocalCompanion extends UpdateCompanion<TimesheetLocalData> {
  final Value<String> timesheetId;
  final Value<String> employeeId;
  final Value<DateTime> weekStart;
  final Value<DateTime> weekEnd;
  final Value<DateTime> date;
  final Value<double> regularHours;
  final Value<double> otHours;
  final Value<String?> notes;
  final Value<double> weeklyTotalHours;
  final Value<double> weeklyOt1Hours;
  final Value<double> estimatedPay;
  final Value<bool> synced;
  final Value<bool> adjusted;
  final Value<bool> flagged;
  final Value<String?> disputeStatus;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const TimesheetLocalCompanion({
    this.timesheetId = const Value.absent(),
    this.employeeId = const Value.absent(),
    this.weekStart = const Value.absent(),
    this.weekEnd = const Value.absent(),
    this.date = const Value.absent(),
    this.regularHours = const Value.absent(),
    this.otHours = const Value.absent(),
    this.notes = const Value.absent(),
    this.weeklyTotalHours = const Value.absent(),
    this.weeklyOt1Hours = const Value.absent(),
    this.estimatedPay = const Value.absent(),
    this.synced = const Value.absent(),
    this.adjusted = const Value.absent(),
    this.flagged = const Value.absent(),
    this.disputeStatus = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TimesheetLocalCompanion.insert({
    required String timesheetId,
    required String employeeId,
    required DateTime weekStart,
    required DateTime weekEnd,
    required DateTime date,
    required double regularHours,
    required double otHours,
    this.notes = const Value.absent(),
    required double weeklyTotalHours,
    required double weeklyOt1Hours,
    required double estimatedPay,
    this.synced = const Value.absent(),
    this.adjusted = const Value.absent(),
    this.flagged = const Value.absent(),
    this.disputeStatus = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : timesheetId = Value(timesheetId),
        employeeId = Value(employeeId),
        weekStart = Value(weekStart),
        weekEnd = Value(weekEnd),
        date = Value(date),
        regularHours = Value(regularHours),
        otHours = Value(otHours),
        weeklyTotalHours = Value(weeklyTotalHours),
        weeklyOt1Hours = Value(weeklyOt1Hours),
        estimatedPay = Value(estimatedPay);
  static Insertable<TimesheetLocalData> custom({
    Expression<String>? timesheetId,
    Expression<String>? employeeId,
    Expression<DateTime>? weekStart,
    Expression<DateTime>? weekEnd,
    Expression<DateTime>? date,
    Expression<double>? regularHours,
    Expression<double>? otHours,
    Expression<String>? notes,
    Expression<double>? weeklyTotalHours,
    Expression<double>? weeklyOt1Hours,
    Expression<double>? estimatedPay,
    Expression<bool>? synced,
    Expression<bool>? adjusted,
    Expression<bool>? flagged,
    Expression<String>? disputeStatus,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (timesheetId != null) 'timesheet_id': timesheetId,
      if (employeeId != null) 'employee_id': employeeId,
      if (weekStart != null) 'week_start': weekStart,
      if (weekEnd != null) 'week_end': weekEnd,
      if (date != null) 'date': date,
      if (regularHours != null) 'regular_hours': regularHours,
      if (otHours != null) 'ot_hours': otHours,
      if (notes != null) 'notes': notes,
      if (weeklyTotalHours != null) 'weekly_total_hours': weeklyTotalHours,
      if (weeklyOt1Hours != null) 'weekly_ot1_hours': weeklyOt1Hours,
      if (estimatedPay != null) 'estimated_pay': estimatedPay,
      if (synced != null) 'synced': synced,
      if (adjusted != null) 'adjusted': adjusted,
      if (flagged != null) 'flagged': flagged,
      if (disputeStatus != null) 'dispute_status': disputeStatus,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TimesheetLocalCompanion copyWith(
      {Value<String>? timesheetId,
      Value<String>? employeeId,
      Value<DateTime>? weekStart,
      Value<DateTime>? weekEnd,
      Value<DateTime>? date,
      Value<double>? regularHours,
      Value<double>? otHours,
      Value<String?>? notes,
      Value<double>? weeklyTotalHours,
      Value<double>? weeklyOt1Hours,
      Value<double>? estimatedPay,
      Value<bool>? synced,
      Value<bool>? adjusted,
      Value<bool>? flagged,
      Value<String?>? disputeStatus,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return TimesheetLocalCompanion(
      timesheetId: timesheetId ?? this.timesheetId,
      employeeId: employeeId ?? this.employeeId,
      weekStart: weekStart ?? this.weekStart,
      weekEnd: weekEnd ?? this.weekEnd,
      date: date ?? this.date,
      regularHours: regularHours ?? this.regularHours,
      otHours: otHours ?? this.otHours,
      notes: notes ?? this.notes,
      weeklyTotalHours: weeklyTotalHours ?? this.weeklyTotalHours,
      weeklyOt1Hours: weeklyOt1Hours ?? this.weeklyOt1Hours,
      estimatedPay: estimatedPay ?? this.estimatedPay,
      synced: synced ?? this.synced,
      adjusted: adjusted ?? this.adjusted,
      flagged: flagged ?? this.flagged,
      disputeStatus: disputeStatus ?? this.disputeStatus,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (timesheetId.present) {
      map['timesheet_id'] = Variable<String>(timesheetId.value);
    }
    if (employeeId.present) {
      map['employee_id'] = Variable<String>(employeeId.value);
    }
    if (weekStart.present) {
      map['week_start'] = Variable<DateTime>(weekStart.value);
    }
    if (weekEnd.present) {
      map['week_end'] = Variable<DateTime>(weekEnd.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (regularHours.present) {
      map['regular_hours'] = Variable<double>(regularHours.value);
    }
    if (otHours.present) {
      map['ot_hours'] = Variable<double>(otHours.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (weeklyTotalHours.present) {
      map['weekly_total_hours'] = Variable<double>(weeklyTotalHours.value);
    }
    if (weeklyOt1Hours.present) {
      map['weekly_ot1_hours'] = Variable<double>(weeklyOt1Hours.value);
    }
    if (estimatedPay.present) {
      map['estimated_pay'] = Variable<double>(estimatedPay.value);
    }
    if (synced.present) {
      map['synced'] = Variable<bool>(synced.value);
    }
    if (adjusted.present) {
      map['adjusted'] = Variable<bool>(adjusted.value);
    }
    if (flagged.present) {
      map['flagged'] = Variable<bool>(flagged.value);
    }
    if (disputeStatus.present) {
      map['dispute_status'] = Variable<String>(disputeStatus.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TimesheetLocalCompanion(')
          ..write('timesheetId: $timesheetId, ')
          ..write('employeeId: $employeeId, ')
          ..write('weekStart: $weekStart, ')
          ..write('weekEnd: $weekEnd, ')
          ..write('date: $date, ')
          ..write('regularHours: $regularHours, ')
          ..write('otHours: $otHours, ')
          ..write('notes: $notes, ')
          ..write('weeklyTotalHours: $weeklyTotalHours, ')
          ..write('weeklyOt1Hours: $weeklyOt1Hours, ')
          ..write('estimatedPay: $estimatedPay, ')
          ..write('synced: $synced, ')
          ..write('adjusted: $adjusted, ')
          ..write('flagged: $flagged, ')
          ..write('disputeStatus: $disputeStatus, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SyncStateLocalTable extends SyncStateLocal
    with TableInfo<$SyncStateLocalTable, SyncStateLocalData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncStateLocalTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
      'key', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _lastSyncedAtMeta =
      const VerificationMeta('lastSyncedAt');
  @override
  late final GeneratedColumn<DateTime> lastSyncedAt = GeneratedColumn<DateTime>(
      'last_synced_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _lastRebuildAtMeta =
      const VerificationMeta('lastRebuildAt');
  @override
  late final GeneratedColumn<DateTime> lastRebuildAt =
      GeneratedColumn<DateTime>('last_rebuild_at', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('idle'));
  static const VerificationMeta _lastErrorMeta =
      const VerificationMeta('lastError');
  @override
  late final GeneratedColumn<String> lastError = GeneratedColumn<String>(
      'last_error', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [key, lastSyncedAt, lastRebuildAt, status, lastError];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_state_local';
  @override
  VerificationContext validateIntegrity(Insertable<SyncStateLocalData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
          _keyMeta, key.isAcceptableOrUnknown(data['key']!, _keyMeta));
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('last_synced_at')) {
      context.handle(
          _lastSyncedAtMeta,
          lastSyncedAt.isAcceptableOrUnknown(
              data['last_synced_at']!, _lastSyncedAtMeta));
    }
    if (data.containsKey('last_rebuild_at')) {
      context.handle(
          _lastRebuildAtMeta,
          lastRebuildAt.isAcceptableOrUnknown(
              data['last_rebuild_at']!, _lastRebuildAtMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('last_error')) {
      context.handle(_lastErrorMeta,
          lastError.isAcceptableOrUnknown(data['last_error']!, _lastErrorMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  SyncStateLocalData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncStateLocalData(
      key: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}key'])!,
      lastSyncedAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}last_synced_at']),
      lastRebuildAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}last_rebuild_at']),
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      lastError: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}last_error']),
    );
  }

  @override
  $SyncStateLocalTable createAlias(String alias) {
    return $SyncStateLocalTable(attachedDatabase, alias);
  }
}

class SyncStateLocalData extends DataClass
    implements Insertable<SyncStateLocalData> {
  final String key;
  final DateTime? lastSyncedAt;
  final DateTime? lastRebuildAt;
  final String status;
  final String? lastError;
  const SyncStateLocalData(
      {required this.key,
      this.lastSyncedAt,
      this.lastRebuildAt,
      required this.status,
      this.lastError});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    if (!nullToAbsent || lastSyncedAt != null) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt);
    }
    if (!nullToAbsent || lastRebuildAt != null) {
      map['last_rebuild_at'] = Variable<DateTime>(lastRebuildAt);
    }
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || lastError != null) {
      map['last_error'] = Variable<String>(lastError);
    }
    return map;
  }

  SyncStateLocalCompanion toCompanion(bool nullToAbsent) {
    return SyncStateLocalCompanion(
      key: Value(key),
      lastSyncedAt: lastSyncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncedAt),
      lastRebuildAt: lastRebuildAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastRebuildAt),
      status: Value(status),
      lastError: lastError == null && nullToAbsent
          ? const Value.absent()
          : Value(lastError),
    );
  }

  factory SyncStateLocalData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncStateLocalData(
      key: serializer.fromJson<String>(json['key']),
      lastSyncedAt: serializer.fromJson<DateTime?>(json['lastSyncedAt']),
      lastRebuildAt: serializer.fromJson<DateTime?>(json['lastRebuildAt']),
      status: serializer.fromJson<String>(json['status']),
      lastError: serializer.fromJson<String?>(json['lastError']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'lastSyncedAt': serializer.toJson<DateTime?>(lastSyncedAt),
      'lastRebuildAt': serializer.toJson<DateTime?>(lastRebuildAt),
      'status': serializer.toJson<String>(status),
      'lastError': serializer.toJson<String?>(lastError),
    };
  }

  SyncStateLocalData copyWith(
          {String? key,
          Value<DateTime?> lastSyncedAt = const Value.absent(),
          Value<DateTime?> lastRebuildAt = const Value.absent(),
          String? status,
          Value<String?> lastError = const Value.absent()}) =>
      SyncStateLocalData(
        key: key ?? this.key,
        lastSyncedAt:
            lastSyncedAt.present ? lastSyncedAt.value : this.lastSyncedAt,
        lastRebuildAt:
            lastRebuildAt.present ? lastRebuildAt.value : this.lastRebuildAt,
        status: status ?? this.status,
        lastError: lastError.present ? lastError.value : this.lastError,
      );
  SyncStateLocalData copyWithCompanion(SyncStateLocalCompanion data) {
    return SyncStateLocalData(
      key: data.key.present ? data.key.value : this.key,
      lastSyncedAt: data.lastSyncedAt.present
          ? data.lastSyncedAt.value
          : this.lastSyncedAt,
      lastRebuildAt: data.lastRebuildAt.present
          ? data.lastRebuildAt.value
          : this.lastRebuildAt,
      status: data.status.present ? data.status.value : this.status,
      lastError: data.lastError.present ? data.lastError.value : this.lastError,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncStateLocalData(')
          ..write('key: $key, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('lastRebuildAt: $lastRebuildAt, ')
          ..write('status: $status, ')
          ..write('lastError: $lastError')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(key, lastSyncedAt, lastRebuildAt, status, lastError);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncStateLocalData &&
          other.key == this.key &&
          other.lastSyncedAt == this.lastSyncedAt &&
          other.lastRebuildAt == this.lastRebuildAt &&
          other.status == this.status &&
          other.lastError == this.lastError);
}

class SyncStateLocalCompanion extends UpdateCompanion<SyncStateLocalData> {
  final Value<String> key;
  final Value<DateTime?> lastSyncedAt;
  final Value<DateTime?> lastRebuildAt;
  final Value<String> status;
  final Value<String?> lastError;
  final Value<int> rowid;
  const SyncStateLocalCompanion({
    this.key = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.lastRebuildAt = const Value.absent(),
    this.status = const Value.absent(),
    this.lastError = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SyncStateLocalCompanion.insert({
    required String key,
    this.lastSyncedAt = const Value.absent(),
    this.lastRebuildAt = const Value.absent(),
    this.status = const Value.absent(),
    this.lastError = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : key = Value(key);
  static Insertable<SyncStateLocalData> custom({
    Expression<String>? key,
    Expression<DateTime>? lastSyncedAt,
    Expression<DateTime>? lastRebuildAt,
    Expression<String>? status,
    Expression<String>? lastError,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (lastSyncedAt != null) 'last_synced_at': lastSyncedAt,
      if (lastRebuildAt != null) 'last_rebuild_at': lastRebuildAt,
      if (status != null) 'status': status,
      if (lastError != null) 'last_error': lastError,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SyncStateLocalCompanion copyWith(
      {Value<String>? key,
      Value<DateTime?>? lastSyncedAt,
      Value<DateTime?>? lastRebuildAt,
      Value<String>? status,
      Value<String?>? lastError,
      Value<int>? rowid}) {
    return SyncStateLocalCompanion(
      key: key ?? this.key,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
      lastRebuildAt: lastRebuildAt ?? this.lastRebuildAt,
      status: status ?? this.status,
      lastError: lastError ?? this.lastError,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (lastSyncedAt.present) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt.value);
    }
    if (lastRebuildAt.present) {
      map['last_rebuild_at'] = Variable<DateTime>(lastRebuildAt.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (lastError.present) {
      map['last_error'] = Variable<String>(lastError.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncStateLocalCompanion(')
          ..write('key: $key, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('lastRebuildAt: $lastRebuildAt, ')
          ..write('status: $status, ')
          ..write('lastError: $lastError, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TimesheetRollupsLocalTable extends TimesheetRollupsLocal
    with TableInfo<$TimesheetRollupsLocalTable, TimesheetRollupsLocalData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TimesheetRollupsLocalTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _employeeIdMeta =
      const VerificationMeta('employeeId');
  @override
  late final GeneratedColumn<String> employeeId = GeneratedColumn<String>(
      'employee_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _weekStartMeta =
      const VerificationMeta('weekStart');
  @override
  late final GeneratedColumn<DateTime> weekStart = GeneratedColumn<DateTime>(
      'week_start', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _totalHoursMeta =
      const VerificationMeta('totalHours');
  @override
  late final GeneratedColumn<double> totalHours = GeneratedColumn<double>(
      'total_hours', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _regularHoursMeta =
      const VerificationMeta('regularHours');
  @override
  late final GeneratedColumn<double> regularHours = GeneratedColumn<double>(
      'regular_hours', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _otHoursMeta =
      const VerificationMeta('otHours');
  @override
  late final GeneratedColumn<double> otHours = GeneratedColumn<double>(
      'ot_hours', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _hashMeta = const VerificationMeta('hash');
  @override
  late final GeneratedColumn<String> hash = GeneratedColumn<String>(
      'hash', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _lastCalculatedAtMeta =
      const VerificationMeta('lastCalculatedAt');
  @override
  late final GeneratedColumn<DateTime> lastCalculatedAt =
      GeneratedColumn<DateTime>('last_calculated_at', aliasedName, false,
          type: DriftSqlType.dateTime,
          requiredDuringInsert: false,
          defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        employeeId,
        weekStart,
        totalHours,
        regularHours,
        otHours,
        hash,
        lastCalculatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'timesheet_rollups_local';
  @override
  VerificationContext validateIntegrity(
      Insertable<TimesheetRollupsLocalData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('employee_id')) {
      context.handle(
          _employeeIdMeta,
          employeeId.isAcceptableOrUnknown(
              data['employee_id']!, _employeeIdMeta));
    } else if (isInserting) {
      context.missing(_employeeIdMeta);
    }
    if (data.containsKey('week_start')) {
      context.handle(_weekStartMeta,
          weekStart.isAcceptableOrUnknown(data['week_start']!, _weekStartMeta));
    } else if (isInserting) {
      context.missing(_weekStartMeta);
    }
    if (data.containsKey('total_hours')) {
      context.handle(
          _totalHoursMeta,
          totalHours.isAcceptableOrUnknown(
              data['total_hours']!, _totalHoursMeta));
    } else if (isInserting) {
      context.missing(_totalHoursMeta);
    }
    if (data.containsKey('regular_hours')) {
      context.handle(
          _regularHoursMeta,
          regularHours.isAcceptableOrUnknown(
              data['regular_hours']!, _regularHoursMeta));
    } else if (isInserting) {
      context.missing(_regularHoursMeta);
    }
    if (data.containsKey('ot_hours')) {
      context.handle(_otHoursMeta,
          otHours.isAcceptableOrUnknown(data['ot_hours']!, _otHoursMeta));
    } else if (isInserting) {
      context.missing(_otHoursMeta);
    }
    if (data.containsKey('hash')) {
      context.handle(
          _hashMeta, hash.isAcceptableOrUnknown(data['hash']!, _hashMeta));
    } else if (isInserting) {
      context.missing(_hashMeta);
    }
    if (data.containsKey('last_calculated_at')) {
      context.handle(
          _lastCalculatedAtMeta,
          lastCalculatedAt.isAcceptableOrUnknown(
              data['last_calculated_at']!, _lastCalculatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {employeeId, weekStart};
  @override
  TimesheetRollupsLocalData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TimesheetRollupsLocalData(
      employeeId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}employee_id'])!,
      weekStart: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}week_start'])!,
      totalHours: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}total_hours'])!,
      regularHours: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}regular_hours'])!,
      otHours: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}ot_hours'])!,
      hash: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}hash'])!,
      lastCalculatedAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}last_calculated_at'])!,
    );
  }

  @override
  $TimesheetRollupsLocalTable createAlias(String alias) {
    return $TimesheetRollupsLocalTable(attachedDatabase, alias);
  }
}

class TimesheetRollupsLocalData extends DataClass
    implements Insertable<TimesheetRollupsLocalData> {
  final String employeeId;
  final DateTime weekStart;
  final double totalHours;
  final double regularHours;
  final double otHours;
  final String hash;
  final DateTime lastCalculatedAt;
  const TimesheetRollupsLocalData(
      {required this.employeeId,
      required this.weekStart,
      required this.totalHours,
      required this.regularHours,
      required this.otHours,
      required this.hash,
      required this.lastCalculatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['employee_id'] = Variable<String>(employeeId);
    map['week_start'] = Variable<DateTime>(weekStart);
    map['total_hours'] = Variable<double>(totalHours);
    map['regular_hours'] = Variable<double>(regularHours);
    map['ot_hours'] = Variable<double>(otHours);
    map['hash'] = Variable<String>(hash);
    map['last_calculated_at'] = Variable<DateTime>(lastCalculatedAt);
    return map;
  }

  TimesheetRollupsLocalCompanion toCompanion(bool nullToAbsent) {
    return TimesheetRollupsLocalCompanion(
      employeeId: Value(employeeId),
      weekStart: Value(weekStart),
      totalHours: Value(totalHours),
      regularHours: Value(regularHours),
      otHours: Value(otHours),
      hash: Value(hash),
      lastCalculatedAt: Value(lastCalculatedAt),
    );
  }

  factory TimesheetRollupsLocalData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TimesheetRollupsLocalData(
      employeeId: serializer.fromJson<String>(json['employeeId']),
      weekStart: serializer.fromJson<DateTime>(json['weekStart']),
      totalHours: serializer.fromJson<double>(json['totalHours']),
      regularHours: serializer.fromJson<double>(json['regularHours']),
      otHours: serializer.fromJson<double>(json['otHours']),
      hash: serializer.fromJson<String>(json['hash']),
      lastCalculatedAt: serializer.fromJson<DateTime>(json['lastCalculatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'employeeId': serializer.toJson<String>(employeeId),
      'weekStart': serializer.toJson<DateTime>(weekStart),
      'totalHours': serializer.toJson<double>(totalHours),
      'regularHours': serializer.toJson<double>(regularHours),
      'otHours': serializer.toJson<double>(otHours),
      'hash': serializer.toJson<String>(hash),
      'lastCalculatedAt': serializer.toJson<DateTime>(lastCalculatedAt),
    };
  }

  TimesheetRollupsLocalData copyWith(
          {String? employeeId,
          DateTime? weekStart,
          double? totalHours,
          double? regularHours,
          double? otHours,
          String? hash,
          DateTime? lastCalculatedAt}) =>
      TimesheetRollupsLocalData(
        employeeId: employeeId ?? this.employeeId,
        weekStart: weekStart ?? this.weekStart,
        totalHours: totalHours ?? this.totalHours,
        regularHours: regularHours ?? this.regularHours,
        otHours: otHours ?? this.otHours,
        hash: hash ?? this.hash,
        lastCalculatedAt: lastCalculatedAt ?? this.lastCalculatedAt,
      );
  TimesheetRollupsLocalData copyWithCompanion(
      TimesheetRollupsLocalCompanion data) {
    return TimesheetRollupsLocalData(
      employeeId:
          data.employeeId.present ? data.employeeId.value : this.employeeId,
      weekStart: data.weekStart.present ? data.weekStart.value : this.weekStart,
      totalHours:
          data.totalHours.present ? data.totalHours.value : this.totalHours,
      regularHours: data.regularHours.present
          ? data.regularHours.value
          : this.regularHours,
      otHours: data.otHours.present ? data.otHours.value : this.otHours,
      hash: data.hash.present ? data.hash.value : this.hash,
      lastCalculatedAt: data.lastCalculatedAt.present
          ? data.lastCalculatedAt.value
          : this.lastCalculatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TimesheetRollupsLocalData(')
          ..write('employeeId: $employeeId, ')
          ..write('weekStart: $weekStart, ')
          ..write('totalHours: $totalHours, ')
          ..write('regularHours: $regularHours, ')
          ..write('otHours: $otHours, ')
          ..write('hash: $hash, ')
          ..write('lastCalculatedAt: $lastCalculatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(employeeId, weekStart, totalHours,
      regularHours, otHours, hash, lastCalculatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TimesheetRollupsLocalData &&
          other.employeeId == this.employeeId &&
          other.weekStart == this.weekStart &&
          other.totalHours == this.totalHours &&
          other.regularHours == this.regularHours &&
          other.otHours == this.otHours &&
          other.hash == this.hash &&
          other.lastCalculatedAt == this.lastCalculatedAt);
}

class TimesheetRollupsLocalCompanion
    extends UpdateCompanion<TimesheetRollupsLocalData> {
  final Value<String> employeeId;
  final Value<DateTime> weekStart;
  final Value<double> totalHours;
  final Value<double> regularHours;
  final Value<double> otHours;
  final Value<String> hash;
  final Value<DateTime> lastCalculatedAt;
  final Value<int> rowid;
  const TimesheetRollupsLocalCompanion({
    this.employeeId = const Value.absent(),
    this.weekStart = const Value.absent(),
    this.totalHours = const Value.absent(),
    this.regularHours = const Value.absent(),
    this.otHours = const Value.absent(),
    this.hash = const Value.absent(),
    this.lastCalculatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TimesheetRollupsLocalCompanion.insert({
    required String employeeId,
    required DateTime weekStart,
    required double totalHours,
    required double regularHours,
    required double otHours,
    required String hash,
    this.lastCalculatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : employeeId = Value(employeeId),
        weekStart = Value(weekStart),
        totalHours = Value(totalHours),
        regularHours = Value(regularHours),
        otHours = Value(otHours),
        hash = Value(hash);
  static Insertable<TimesheetRollupsLocalData> custom({
    Expression<String>? employeeId,
    Expression<DateTime>? weekStart,
    Expression<double>? totalHours,
    Expression<double>? regularHours,
    Expression<double>? otHours,
    Expression<String>? hash,
    Expression<DateTime>? lastCalculatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (employeeId != null) 'employee_id': employeeId,
      if (weekStart != null) 'week_start': weekStart,
      if (totalHours != null) 'total_hours': totalHours,
      if (regularHours != null) 'regular_hours': regularHours,
      if (otHours != null) 'ot_hours': otHours,
      if (hash != null) 'hash': hash,
      if (lastCalculatedAt != null) 'last_calculated_at': lastCalculatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TimesheetRollupsLocalCompanion copyWith(
      {Value<String>? employeeId,
      Value<DateTime>? weekStart,
      Value<double>? totalHours,
      Value<double>? regularHours,
      Value<double>? otHours,
      Value<String>? hash,
      Value<DateTime>? lastCalculatedAt,
      Value<int>? rowid}) {
    return TimesheetRollupsLocalCompanion(
      employeeId: employeeId ?? this.employeeId,
      weekStart: weekStart ?? this.weekStart,
      totalHours: totalHours ?? this.totalHours,
      regularHours: regularHours ?? this.regularHours,
      otHours: otHours ?? this.otHours,
      hash: hash ?? this.hash,
      lastCalculatedAt: lastCalculatedAt ?? this.lastCalculatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (employeeId.present) {
      map['employee_id'] = Variable<String>(employeeId.value);
    }
    if (weekStart.present) {
      map['week_start'] = Variable<DateTime>(weekStart.value);
    }
    if (totalHours.present) {
      map['total_hours'] = Variable<double>(totalHours.value);
    }
    if (regularHours.present) {
      map['regular_hours'] = Variable<double>(regularHours.value);
    }
    if (otHours.present) {
      map['ot_hours'] = Variable<double>(otHours.value);
    }
    if (hash.present) {
      map['hash'] = Variable<String>(hash.value);
    }
    if (lastCalculatedAt.present) {
      map['last_calculated_at'] = Variable<DateTime>(lastCalculatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TimesheetRollupsLocalCompanion(')
          ..write('employeeId: $employeeId, ')
          ..write('weekStart: $weekStart, ')
          ..write('totalHours: $totalHours, ')
          ..write('regularHours: $regularHours, ')
          ..write('otHours: $otHours, ')
          ..write('hash: $hash, ')
          ..write('lastCalculatedAt: $lastCalculatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MissingJobLinksTable extends MissingJobLinks
    with TableInfo<$MissingJobLinksTable, MissingJobLink> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MissingJobLinksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _punchIdMeta =
      const VerificationMeta('punchId');
  @override
  late final GeneratedColumn<String> punchId = GeneratedColumn<String>(
      'punch_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _jobIdMeta = const VerificationMeta('jobId');
  @override
  late final GeneratedColumn<String> jobId = GeneratedColumn<String>(
      'job_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _detectedAtMeta =
      const VerificationMeta('detectedAt');
  @override
  late final GeneratedColumn<DateTime> detectedAt = GeneratedColumn<DateTime>(
      'detected_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _fetchAttemptsMeta =
      const VerificationMeta('fetchAttempts');
  @override
  late final GeneratedColumn<int> fetchAttempts = GeneratedColumn<int>(
      'fetch_attempts', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _lastFetchAttemptMeta =
      const VerificationMeta('lastFetchAttempt');
  @override
  late final GeneratedColumn<DateTime> lastFetchAttempt =
      GeneratedColumn<DateTime>('last_fetch_attempt', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [punchId, jobId, detectedAt, fetchAttempts, lastFetchAttempt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'missing_job_links';
  @override
  VerificationContext validateIntegrity(Insertable<MissingJobLink> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('punch_id')) {
      context.handle(_punchIdMeta,
          punchId.isAcceptableOrUnknown(data['punch_id']!, _punchIdMeta));
    } else if (isInserting) {
      context.missing(_punchIdMeta);
    }
    if (data.containsKey('job_id')) {
      context.handle(
          _jobIdMeta, jobId.isAcceptableOrUnknown(data['job_id']!, _jobIdMeta));
    } else if (isInserting) {
      context.missing(_jobIdMeta);
    }
    if (data.containsKey('detected_at')) {
      context.handle(
          _detectedAtMeta,
          detectedAt.isAcceptableOrUnknown(
              data['detected_at']!, _detectedAtMeta));
    }
    if (data.containsKey('fetch_attempts')) {
      context.handle(
          _fetchAttemptsMeta,
          fetchAttempts.isAcceptableOrUnknown(
              data['fetch_attempts']!, _fetchAttemptsMeta));
    }
    if (data.containsKey('last_fetch_attempt')) {
      context.handle(
          _lastFetchAttemptMeta,
          lastFetchAttempt.isAcceptableOrUnknown(
              data['last_fetch_attempt']!, _lastFetchAttemptMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {punchId, jobId};
  @override
  MissingJobLink map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MissingJobLink(
      punchId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}punch_id'])!,
      jobId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}job_id'])!,
      detectedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}detected_at'])!,
      fetchAttempts: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}fetch_attempts'])!,
      lastFetchAttempt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}last_fetch_attempt']),
    );
  }

  @override
  $MissingJobLinksTable createAlias(String alias) {
    return $MissingJobLinksTable(attachedDatabase, alias);
  }
}

class MissingJobLink extends DataClass implements Insertable<MissingJobLink> {
  final String punchId;
  final String jobId;
  final DateTime detectedAt;
  final int fetchAttempts;
  final DateTime? lastFetchAttempt;
  const MissingJobLink(
      {required this.punchId,
      required this.jobId,
      required this.detectedAt,
      required this.fetchAttempts,
      this.lastFetchAttempt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['punch_id'] = Variable<String>(punchId);
    map['job_id'] = Variable<String>(jobId);
    map['detected_at'] = Variable<DateTime>(detectedAt);
    map['fetch_attempts'] = Variable<int>(fetchAttempts);
    if (!nullToAbsent || lastFetchAttempt != null) {
      map['last_fetch_attempt'] = Variable<DateTime>(lastFetchAttempt);
    }
    return map;
  }

  MissingJobLinksCompanion toCompanion(bool nullToAbsent) {
    return MissingJobLinksCompanion(
      punchId: Value(punchId),
      jobId: Value(jobId),
      detectedAt: Value(detectedAt),
      fetchAttempts: Value(fetchAttempts),
      lastFetchAttempt: lastFetchAttempt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastFetchAttempt),
    );
  }

  factory MissingJobLink.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MissingJobLink(
      punchId: serializer.fromJson<String>(json['punchId']),
      jobId: serializer.fromJson<String>(json['jobId']),
      detectedAt: serializer.fromJson<DateTime>(json['detectedAt']),
      fetchAttempts: serializer.fromJson<int>(json['fetchAttempts']),
      lastFetchAttempt:
          serializer.fromJson<DateTime?>(json['lastFetchAttempt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'punchId': serializer.toJson<String>(punchId),
      'jobId': serializer.toJson<String>(jobId),
      'detectedAt': serializer.toJson<DateTime>(detectedAt),
      'fetchAttempts': serializer.toJson<int>(fetchAttempts),
      'lastFetchAttempt': serializer.toJson<DateTime?>(lastFetchAttempt),
    };
  }

  MissingJobLink copyWith(
          {String? punchId,
          String? jobId,
          DateTime? detectedAt,
          int? fetchAttempts,
          Value<DateTime?> lastFetchAttempt = const Value.absent()}) =>
      MissingJobLink(
        punchId: punchId ?? this.punchId,
        jobId: jobId ?? this.jobId,
        detectedAt: detectedAt ?? this.detectedAt,
        fetchAttempts: fetchAttempts ?? this.fetchAttempts,
        lastFetchAttempt: lastFetchAttempt.present
            ? lastFetchAttempt.value
            : this.lastFetchAttempt,
      );
  MissingJobLink copyWithCompanion(MissingJobLinksCompanion data) {
    return MissingJobLink(
      punchId: data.punchId.present ? data.punchId.value : this.punchId,
      jobId: data.jobId.present ? data.jobId.value : this.jobId,
      detectedAt:
          data.detectedAt.present ? data.detectedAt.value : this.detectedAt,
      fetchAttempts: data.fetchAttempts.present
          ? data.fetchAttempts.value
          : this.fetchAttempts,
      lastFetchAttempt: data.lastFetchAttempt.present
          ? data.lastFetchAttempt.value
          : this.lastFetchAttempt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MissingJobLink(')
          ..write('punchId: $punchId, ')
          ..write('jobId: $jobId, ')
          ..write('detectedAt: $detectedAt, ')
          ..write('fetchAttempts: $fetchAttempts, ')
          ..write('lastFetchAttempt: $lastFetchAttempt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(punchId, jobId, detectedAt, fetchAttempts, lastFetchAttempt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MissingJobLink &&
          other.punchId == this.punchId &&
          other.jobId == this.jobId &&
          other.detectedAt == this.detectedAt &&
          other.fetchAttempts == this.fetchAttempts &&
          other.lastFetchAttempt == this.lastFetchAttempt);
}

class MissingJobLinksCompanion extends UpdateCompanion<MissingJobLink> {
  final Value<String> punchId;
  final Value<String> jobId;
  final Value<DateTime> detectedAt;
  final Value<int> fetchAttempts;
  final Value<DateTime?> lastFetchAttempt;
  final Value<int> rowid;
  const MissingJobLinksCompanion({
    this.punchId = const Value.absent(),
    this.jobId = const Value.absent(),
    this.detectedAt = const Value.absent(),
    this.fetchAttempts = const Value.absent(),
    this.lastFetchAttempt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MissingJobLinksCompanion.insert({
    required String punchId,
    required String jobId,
    this.detectedAt = const Value.absent(),
    this.fetchAttempts = const Value.absent(),
    this.lastFetchAttempt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : punchId = Value(punchId),
        jobId = Value(jobId);
  static Insertable<MissingJobLink> custom({
    Expression<String>? punchId,
    Expression<String>? jobId,
    Expression<DateTime>? detectedAt,
    Expression<int>? fetchAttempts,
    Expression<DateTime>? lastFetchAttempt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (punchId != null) 'punch_id': punchId,
      if (jobId != null) 'job_id': jobId,
      if (detectedAt != null) 'detected_at': detectedAt,
      if (fetchAttempts != null) 'fetch_attempts': fetchAttempts,
      if (lastFetchAttempt != null) 'last_fetch_attempt': lastFetchAttempt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MissingJobLinksCompanion copyWith(
      {Value<String>? punchId,
      Value<String>? jobId,
      Value<DateTime>? detectedAt,
      Value<int>? fetchAttempts,
      Value<DateTime?>? lastFetchAttempt,
      Value<int>? rowid}) {
    return MissingJobLinksCompanion(
      punchId: punchId ?? this.punchId,
      jobId: jobId ?? this.jobId,
      detectedAt: detectedAt ?? this.detectedAt,
      fetchAttempts: fetchAttempts ?? this.fetchAttempts,
      lastFetchAttempt: lastFetchAttempt ?? this.lastFetchAttempt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (punchId.present) {
      map['punch_id'] = Variable<String>(punchId.value);
    }
    if (jobId.present) {
      map['job_id'] = Variable<String>(jobId.value);
    }
    if (detectedAt.present) {
      map['detected_at'] = Variable<DateTime>(detectedAt.value);
    }
    if (fetchAttempts.present) {
      map['fetch_attempts'] = Variable<int>(fetchAttempts.value);
    }
    if (lastFetchAttempt.present) {
      map['last_fetch_attempt'] = Variable<DateTime>(lastFetchAttempt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MissingJobLinksCompanion(')
          ..write('punchId: $punchId, ')
          ..write('jobId: $jobId, ')
          ..write('detectedAt: $detectedAt, ')
          ..write('fetchAttempts: $fetchAttempts, ')
          ..write('lastFetchAttempt: $lastFetchAttempt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TimesheetFlagsLocalTable extends TimesheetFlagsLocal
    with TableInfo<$TimesheetFlagsLocalTable, TimesheetFlagsLocalData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TimesheetFlagsLocalTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _flagIdMeta = const VerificationMeta('flagId');
  @override
  late final GeneratedColumn<String> flagId = GeneratedColumn<String>(
      'flag_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _punchIdMeta =
      const VerificationMeta('punchId');
  @override
  late final GeneratedColumn<String> punchId = GeneratedColumn<String>(
      'punch_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _timesheetIdMeta =
      const VerificationMeta('timesheetId');
  @override
  late final GeneratedColumn<String> timesheetId = GeneratedColumn<String>(
      'timesheet_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _employeeIdMeta =
      const VerificationMeta('employeeId');
  @override
  late final GeneratedColumn<String> employeeId = GeneratedColumn<String>(
      'employee_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
      'code', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _messageMeta =
      const VerificationMeta('message');
  @override
  late final GeneratedColumn<String> message = GeneratedColumn<String>(
      'message', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _severityMeta =
      const VerificationMeta('severity');
  @override
  late final GeneratedColumn<String> severity = GeneratedColumn<String>(
      'severity', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _resolvedMeta =
      const VerificationMeta('resolved');
  @override
  late final GeneratedColumn<bool> resolved = GeneratedColumn<bool>(
      'resolved', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("resolved" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        flagId,
        punchId,
        timesheetId,
        employeeId,
        date,
        code,
        message,
        severity,
        resolved,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'timesheet_flags_local';
  @override
  VerificationContext validateIntegrity(
      Insertable<TimesheetFlagsLocalData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('flag_id')) {
      context.handle(_flagIdMeta,
          flagId.isAcceptableOrUnknown(data['flag_id']!, _flagIdMeta));
    } else if (isInserting) {
      context.missing(_flagIdMeta);
    }
    if (data.containsKey('punch_id')) {
      context.handle(_punchIdMeta,
          punchId.isAcceptableOrUnknown(data['punch_id']!, _punchIdMeta));
    }
    if (data.containsKey('timesheet_id')) {
      context.handle(
          _timesheetIdMeta,
          timesheetId.isAcceptableOrUnknown(
              data['timesheet_id']!, _timesheetIdMeta));
    }
    if (data.containsKey('employee_id')) {
      context.handle(
          _employeeIdMeta,
          employeeId.isAcceptableOrUnknown(
              data['employee_id']!, _employeeIdMeta));
    } else if (isInserting) {
      context.missing(_employeeIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('code')) {
      context.handle(
          _codeMeta, code.isAcceptableOrUnknown(data['code']!, _codeMeta));
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('message')) {
      context.handle(_messageMeta,
          message.isAcceptableOrUnknown(data['message']!, _messageMeta));
    } else if (isInserting) {
      context.missing(_messageMeta);
    }
    if (data.containsKey('severity')) {
      context.handle(_severityMeta,
          severity.isAcceptableOrUnknown(data['severity']!, _severityMeta));
    } else if (isInserting) {
      context.missing(_severityMeta);
    }
    if (data.containsKey('resolved')) {
      context.handle(_resolvedMeta,
          resolved.isAcceptableOrUnknown(data['resolved']!, _resolvedMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {flagId};
  @override
  TimesheetFlagsLocalData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TimesheetFlagsLocalData(
      flagId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}flag_id'])!,
      punchId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}punch_id']),
      timesheetId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}timesheet_id']),
      employeeId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}employee_id'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code'])!,
      message: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}message'])!,
      severity: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}severity'])!,
      resolved: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}resolved'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $TimesheetFlagsLocalTable createAlias(String alias) {
    return $TimesheetFlagsLocalTable(attachedDatabase, alias);
  }
}

class TimesheetFlagsLocalData extends DataClass
    implements Insertable<TimesheetFlagsLocalData> {
  final String flagId;
  final String? punchId;
  final String? timesheetId;
  final String employeeId;
  final DateTime date;
  final String code;
  final String message;
  final String severity;
  final bool resolved;
  final DateTime createdAt;
  const TimesheetFlagsLocalData(
      {required this.flagId,
      this.punchId,
      this.timesheetId,
      required this.employeeId,
      required this.date,
      required this.code,
      required this.message,
      required this.severity,
      required this.resolved,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['flag_id'] = Variable<String>(flagId);
    if (!nullToAbsent || punchId != null) {
      map['punch_id'] = Variable<String>(punchId);
    }
    if (!nullToAbsent || timesheetId != null) {
      map['timesheet_id'] = Variable<String>(timesheetId);
    }
    map['employee_id'] = Variable<String>(employeeId);
    map['date'] = Variable<DateTime>(date);
    map['code'] = Variable<String>(code);
    map['message'] = Variable<String>(message);
    map['severity'] = Variable<String>(severity);
    map['resolved'] = Variable<bool>(resolved);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  TimesheetFlagsLocalCompanion toCompanion(bool nullToAbsent) {
    return TimesheetFlagsLocalCompanion(
      flagId: Value(flagId),
      punchId: punchId == null && nullToAbsent
          ? const Value.absent()
          : Value(punchId),
      timesheetId: timesheetId == null && nullToAbsent
          ? const Value.absent()
          : Value(timesheetId),
      employeeId: Value(employeeId),
      date: Value(date),
      code: Value(code),
      message: Value(message),
      severity: Value(severity),
      resolved: Value(resolved),
      createdAt: Value(createdAt),
    );
  }

  factory TimesheetFlagsLocalData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TimesheetFlagsLocalData(
      flagId: serializer.fromJson<String>(json['flagId']),
      punchId: serializer.fromJson<String?>(json['punchId']),
      timesheetId: serializer.fromJson<String?>(json['timesheetId']),
      employeeId: serializer.fromJson<String>(json['employeeId']),
      date: serializer.fromJson<DateTime>(json['date']),
      code: serializer.fromJson<String>(json['code']),
      message: serializer.fromJson<String>(json['message']),
      severity: serializer.fromJson<String>(json['severity']),
      resolved: serializer.fromJson<bool>(json['resolved']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'flagId': serializer.toJson<String>(flagId),
      'punchId': serializer.toJson<String?>(punchId),
      'timesheetId': serializer.toJson<String?>(timesheetId),
      'employeeId': serializer.toJson<String>(employeeId),
      'date': serializer.toJson<DateTime>(date),
      'code': serializer.toJson<String>(code),
      'message': serializer.toJson<String>(message),
      'severity': serializer.toJson<String>(severity),
      'resolved': serializer.toJson<bool>(resolved),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  TimesheetFlagsLocalData copyWith(
          {String? flagId,
          Value<String?> punchId = const Value.absent(),
          Value<String?> timesheetId = const Value.absent(),
          String? employeeId,
          DateTime? date,
          String? code,
          String? message,
          String? severity,
          bool? resolved,
          DateTime? createdAt}) =>
      TimesheetFlagsLocalData(
        flagId: flagId ?? this.flagId,
        punchId: punchId.present ? punchId.value : this.punchId,
        timesheetId: timesheetId.present ? timesheetId.value : this.timesheetId,
        employeeId: employeeId ?? this.employeeId,
        date: date ?? this.date,
        code: code ?? this.code,
        message: message ?? this.message,
        severity: severity ?? this.severity,
        resolved: resolved ?? this.resolved,
        createdAt: createdAt ?? this.createdAt,
      );
  TimesheetFlagsLocalData copyWithCompanion(TimesheetFlagsLocalCompanion data) {
    return TimesheetFlagsLocalData(
      flagId: data.flagId.present ? data.flagId.value : this.flagId,
      punchId: data.punchId.present ? data.punchId.value : this.punchId,
      timesheetId:
          data.timesheetId.present ? data.timesheetId.value : this.timesheetId,
      employeeId:
          data.employeeId.present ? data.employeeId.value : this.employeeId,
      date: data.date.present ? data.date.value : this.date,
      code: data.code.present ? data.code.value : this.code,
      message: data.message.present ? data.message.value : this.message,
      severity: data.severity.present ? data.severity.value : this.severity,
      resolved: data.resolved.present ? data.resolved.value : this.resolved,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TimesheetFlagsLocalData(')
          ..write('flagId: $flagId, ')
          ..write('punchId: $punchId, ')
          ..write('timesheetId: $timesheetId, ')
          ..write('employeeId: $employeeId, ')
          ..write('date: $date, ')
          ..write('code: $code, ')
          ..write('message: $message, ')
          ..write('severity: $severity, ')
          ..write('resolved: $resolved, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(flagId, punchId, timesheetId, employeeId,
      date, code, message, severity, resolved, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TimesheetFlagsLocalData &&
          other.flagId == this.flagId &&
          other.punchId == this.punchId &&
          other.timesheetId == this.timesheetId &&
          other.employeeId == this.employeeId &&
          other.date == this.date &&
          other.code == this.code &&
          other.message == this.message &&
          other.severity == this.severity &&
          other.resolved == this.resolved &&
          other.createdAt == this.createdAt);
}

class TimesheetFlagsLocalCompanion
    extends UpdateCompanion<TimesheetFlagsLocalData> {
  final Value<String> flagId;
  final Value<String?> punchId;
  final Value<String?> timesheetId;
  final Value<String> employeeId;
  final Value<DateTime> date;
  final Value<String> code;
  final Value<String> message;
  final Value<String> severity;
  final Value<bool> resolved;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const TimesheetFlagsLocalCompanion({
    this.flagId = const Value.absent(),
    this.punchId = const Value.absent(),
    this.timesheetId = const Value.absent(),
    this.employeeId = const Value.absent(),
    this.date = const Value.absent(),
    this.code = const Value.absent(),
    this.message = const Value.absent(),
    this.severity = const Value.absent(),
    this.resolved = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TimesheetFlagsLocalCompanion.insert({
    required String flagId,
    this.punchId = const Value.absent(),
    this.timesheetId = const Value.absent(),
    required String employeeId,
    required DateTime date,
    required String code,
    required String message,
    required String severity,
    this.resolved = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : flagId = Value(flagId),
        employeeId = Value(employeeId),
        date = Value(date),
        code = Value(code),
        message = Value(message),
        severity = Value(severity);
  static Insertable<TimesheetFlagsLocalData> custom({
    Expression<String>? flagId,
    Expression<String>? punchId,
    Expression<String>? timesheetId,
    Expression<String>? employeeId,
    Expression<DateTime>? date,
    Expression<String>? code,
    Expression<String>? message,
    Expression<String>? severity,
    Expression<bool>? resolved,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (flagId != null) 'flag_id': flagId,
      if (punchId != null) 'punch_id': punchId,
      if (timesheetId != null) 'timesheet_id': timesheetId,
      if (employeeId != null) 'employee_id': employeeId,
      if (date != null) 'date': date,
      if (code != null) 'code': code,
      if (message != null) 'message': message,
      if (severity != null) 'severity': severity,
      if (resolved != null) 'resolved': resolved,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TimesheetFlagsLocalCompanion copyWith(
      {Value<String>? flagId,
      Value<String?>? punchId,
      Value<String?>? timesheetId,
      Value<String>? employeeId,
      Value<DateTime>? date,
      Value<String>? code,
      Value<String>? message,
      Value<String>? severity,
      Value<bool>? resolved,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return TimesheetFlagsLocalCompanion(
      flagId: flagId ?? this.flagId,
      punchId: punchId ?? this.punchId,
      timesheetId: timesheetId ?? this.timesheetId,
      employeeId: employeeId ?? this.employeeId,
      date: date ?? this.date,
      code: code ?? this.code,
      message: message ?? this.message,
      severity: severity ?? this.severity,
      resolved: resolved ?? this.resolved,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (flagId.present) {
      map['flag_id'] = Variable<String>(flagId.value);
    }
    if (punchId.present) {
      map['punch_id'] = Variable<String>(punchId.value);
    }
    if (timesheetId.present) {
      map['timesheet_id'] = Variable<String>(timesheetId.value);
    }
    if (employeeId.present) {
      map['employee_id'] = Variable<String>(employeeId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (message.present) {
      map['message'] = Variable<String>(message.value);
    }
    if (severity.present) {
      map['severity'] = Variable<String>(severity.value);
    }
    if (resolved.present) {
      map['resolved'] = Variable<bool>(resolved.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TimesheetFlagsLocalCompanion(')
          ..write('flagId: $flagId, ')
          ..write('punchId: $punchId, ')
          ..write('timesheetId: $timesheetId, ')
          ..write('employeeId: $employeeId, ')
          ..write('date: $date, ')
          ..write('code: $code, ')
          ..write('message: $message, ')
          ..write('severity: $severity, ')
          ..write('resolved: $resolved, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $PunchesLocalTable punchesLocal = $PunchesLocalTable(this);
  late final $JobsLocalTable jobsLocal = $JobsLocalTable(this);
  late final $JobFeedStateLocalTable jobFeedStateLocal =
      $JobFeedStateLocalTable(this);
  late final $ProfileLocalTable profileLocal = $ProfileLocalTable(this);
  late final $SyncQueueTable syncQueue = $SyncQueueTable(this);
  late final $CorruptQueueEntriesTable corruptQueueEntries =
      $CorruptQueueEntriesTable(this);
  late final $TimesheetLocalTable timesheetLocal = $TimesheetLocalTable(this);
  late final $SyncStateLocalTable syncStateLocal = $SyncStateLocalTable(this);
  late final $TimesheetRollupsLocalTable timesheetRollupsLocal =
      $TimesheetRollupsLocalTable(this);
  late final $MissingJobLinksTable missingJobLinks =
      $MissingJobLinksTable(this);
  late final $TimesheetFlagsLocalTable timesheetFlagsLocal =
      $TimesheetFlagsLocalTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        punchesLocal,
        jobsLocal,
        jobFeedStateLocal,
        profileLocal,
        syncQueue,
        corruptQueueEntries,
        timesheetLocal,
        syncStateLocal,
        timesheetRollupsLocal,
        missingJobLinks,
        timesheetFlagsLocal
      ];
}

typedef $$PunchesLocalTableCreateCompanionBuilder = PunchesLocalCompanion
    Function({
  required String punchId,
  required String employeeId,
  required String jobId,
  Value<String?> serviceId,
  required String punchType,
  required DateTime timestampDevice,
  Value<double?> gpsLat,
  Value<double?> gpsLng,
  Value<double?> gpsAccuracy,
  Value<bool> gpsUnavailable,
  Value<bool> synced,
  Value<int> syncAttempts,
  Value<String> source,
  Value<String?> deviceId,
  Value<String?> lastError,
  Value<bool> requiresDispute,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});
typedef $$PunchesLocalTableUpdateCompanionBuilder = PunchesLocalCompanion
    Function({
  Value<String> punchId,
  Value<String> employeeId,
  Value<String> jobId,
  Value<String?> serviceId,
  Value<String> punchType,
  Value<DateTime> timestampDevice,
  Value<double?> gpsLat,
  Value<double?> gpsLng,
  Value<double?> gpsAccuracy,
  Value<bool> gpsUnavailable,
  Value<bool> synced,
  Value<int> syncAttempts,
  Value<String> source,
  Value<String?> deviceId,
  Value<String?> lastError,
  Value<bool> requiresDispute,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$PunchesLocalTableFilterComposer
    extends Composer<_$AppDatabase, $PunchesLocalTable> {
  $$PunchesLocalTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get punchId => $composableBuilder(
      column: $table.punchId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get employeeId => $composableBuilder(
      column: $table.employeeId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get jobId => $composableBuilder(
      column: $table.jobId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get serviceId => $composableBuilder(
      column: $table.serviceId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get punchType => $composableBuilder(
      column: $table.punchType, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get timestampDevice => $composableBuilder(
      column: $table.timestampDevice,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get gpsLat => $composableBuilder(
      column: $table.gpsLat, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get gpsLng => $composableBuilder(
      column: $table.gpsLng, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get gpsAccuracy => $composableBuilder(
      column: $table.gpsAccuracy, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get gpsUnavailable => $composableBuilder(
      column: $table.gpsUnavailable,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get synced => $composableBuilder(
      column: $table.synced, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get syncAttempts => $composableBuilder(
      column: $table.syncAttempts, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get source => $composableBuilder(
      column: $table.source, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get deviceId => $composableBuilder(
      column: $table.deviceId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get lastError => $composableBuilder(
      column: $table.lastError, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get requiresDispute => $composableBuilder(
      column: $table.requiresDispute,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$PunchesLocalTableOrderingComposer
    extends Composer<_$AppDatabase, $PunchesLocalTable> {
  $$PunchesLocalTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get punchId => $composableBuilder(
      column: $table.punchId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get employeeId => $composableBuilder(
      column: $table.employeeId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get jobId => $composableBuilder(
      column: $table.jobId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get serviceId => $composableBuilder(
      column: $table.serviceId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get punchType => $composableBuilder(
      column: $table.punchType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get timestampDevice => $composableBuilder(
      column: $table.timestampDevice,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get gpsLat => $composableBuilder(
      column: $table.gpsLat, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get gpsLng => $composableBuilder(
      column: $table.gpsLng, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get gpsAccuracy => $composableBuilder(
      column: $table.gpsAccuracy, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get gpsUnavailable => $composableBuilder(
      column: $table.gpsUnavailable,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get synced => $composableBuilder(
      column: $table.synced, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get syncAttempts => $composableBuilder(
      column: $table.syncAttempts,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get source => $composableBuilder(
      column: $table.source, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get deviceId => $composableBuilder(
      column: $table.deviceId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get lastError => $composableBuilder(
      column: $table.lastError, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get requiresDispute => $composableBuilder(
      column: $table.requiresDispute,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$PunchesLocalTableAnnotationComposer
    extends Composer<_$AppDatabase, $PunchesLocalTable> {
  $$PunchesLocalTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get punchId =>
      $composableBuilder(column: $table.punchId, builder: (column) => column);

  GeneratedColumn<String> get employeeId => $composableBuilder(
      column: $table.employeeId, builder: (column) => column);

  GeneratedColumn<String> get jobId =>
      $composableBuilder(column: $table.jobId, builder: (column) => column);

  GeneratedColumn<String> get serviceId =>
      $composableBuilder(column: $table.serviceId, builder: (column) => column);

  GeneratedColumn<String> get punchType =>
      $composableBuilder(column: $table.punchType, builder: (column) => column);

  GeneratedColumn<DateTime> get timestampDevice => $composableBuilder(
      column: $table.timestampDevice, builder: (column) => column);

  GeneratedColumn<double> get gpsLat =>
      $composableBuilder(column: $table.gpsLat, builder: (column) => column);

  GeneratedColumn<double> get gpsLng =>
      $composableBuilder(column: $table.gpsLng, builder: (column) => column);

  GeneratedColumn<double> get gpsAccuracy => $composableBuilder(
      column: $table.gpsAccuracy, builder: (column) => column);

  GeneratedColumn<bool> get gpsUnavailable => $composableBuilder(
      column: $table.gpsUnavailable, builder: (column) => column);

  GeneratedColumn<bool> get synced =>
      $composableBuilder(column: $table.synced, builder: (column) => column);

  GeneratedColumn<int> get syncAttempts => $composableBuilder(
      column: $table.syncAttempts, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<String> get deviceId =>
      $composableBuilder(column: $table.deviceId, builder: (column) => column);

  GeneratedColumn<String> get lastError =>
      $composableBuilder(column: $table.lastError, builder: (column) => column);

  GeneratedColumn<bool> get requiresDispute => $composableBuilder(
      column: $table.requiresDispute, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$PunchesLocalTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PunchesLocalTable,
    PunchesLocalData,
    $$PunchesLocalTableFilterComposer,
    $$PunchesLocalTableOrderingComposer,
    $$PunchesLocalTableAnnotationComposer,
    $$PunchesLocalTableCreateCompanionBuilder,
    $$PunchesLocalTableUpdateCompanionBuilder,
    (
      PunchesLocalData,
      BaseReferences<_$AppDatabase, $PunchesLocalTable, PunchesLocalData>
    ),
    PunchesLocalData,
    PrefetchHooks Function()> {
  $$PunchesLocalTableTableManager(_$AppDatabase db, $PunchesLocalTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PunchesLocalTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PunchesLocalTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PunchesLocalTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> punchId = const Value.absent(),
            Value<String> employeeId = const Value.absent(),
            Value<String> jobId = const Value.absent(),
            Value<String?> serviceId = const Value.absent(),
            Value<String> punchType = const Value.absent(),
            Value<DateTime> timestampDevice = const Value.absent(),
            Value<double?> gpsLat = const Value.absent(),
            Value<double?> gpsLng = const Value.absent(),
            Value<double?> gpsAccuracy = const Value.absent(),
            Value<bool> gpsUnavailable = const Value.absent(),
            Value<bool> synced = const Value.absent(),
            Value<int> syncAttempts = const Value.absent(),
            Value<String> source = const Value.absent(),
            Value<String?> deviceId = const Value.absent(),
            Value<String?> lastError = const Value.absent(),
            Value<bool> requiresDispute = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PunchesLocalCompanion(
            punchId: punchId,
            employeeId: employeeId,
            jobId: jobId,
            serviceId: serviceId,
            punchType: punchType,
            timestampDevice: timestampDevice,
            gpsLat: gpsLat,
            gpsLng: gpsLng,
            gpsAccuracy: gpsAccuracy,
            gpsUnavailable: gpsUnavailable,
            synced: synced,
            syncAttempts: syncAttempts,
            source: source,
            deviceId: deviceId,
            lastError: lastError,
            requiresDispute: requiresDispute,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String punchId,
            required String employeeId,
            required String jobId,
            Value<String?> serviceId = const Value.absent(),
            required String punchType,
            required DateTime timestampDevice,
            Value<double?> gpsLat = const Value.absent(),
            Value<double?> gpsLng = const Value.absent(),
            Value<double?> gpsAccuracy = const Value.absent(),
            Value<bool> gpsUnavailable = const Value.absent(),
            Value<bool> synced = const Value.absent(),
            Value<int> syncAttempts = const Value.absent(),
            Value<String> source = const Value.absent(),
            Value<String?> deviceId = const Value.absent(),
            Value<String?> lastError = const Value.absent(),
            Value<bool> requiresDispute = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PunchesLocalCompanion.insert(
            punchId: punchId,
            employeeId: employeeId,
            jobId: jobId,
            serviceId: serviceId,
            punchType: punchType,
            timestampDevice: timestampDevice,
            gpsLat: gpsLat,
            gpsLng: gpsLng,
            gpsAccuracy: gpsAccuracy,
            gpsUnavailable: gpsUnavailable,
            synced: synced,
            syncAttempts: syncAttempts,
            source: source,
            deviceId: deviceId,
            lastError: lastError,
            requiresDispute: requiresDispute,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$PunchesLocalTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PunchesLocalTable,
    PunchesLocalData,
    $$PunchesLocalTableFilterComposer,
    $$PunchesLocalTableOrderingComposer,
    $$PunchesLocalTableAnnotationComposer,
    $$PunchesLocalTableCreateCompanionBuilder,
    $$PunchesLocalTableUpdateCompanionBuilder,
    (
      PunchesLocalData,
      BaseReferences<_$AppDatabase, $PunchesLocalTable, PunchesLocalData>
    ),
    PunchesLocalData,
    PrefetchHooks Function()>;
typedef $$JobsLocalTableCreateCompanionBuilder = JobsLocalCompanion Function({
  required String jobId,
  required String serviceId,
  required String customerName,
  Value<String?> address,
  required DateTime scheduledDate,
  Value<String?> foremanId,
  Value<String> crewListJson,
  Value<String?> crewHash,
  Value<DateTime> lastUpdated,
  Value<bool> synced,
  Value<int> rowid,
});
typedef $$JobsLocalTableUpdateCompanionBuilder = JobsLocalCompanion Function({
  Value<String> jobId,
  Value<String> serviceId,
  Value<String> customerName,
  Value<String?> address,
  Value<DateTime> scheduledDate,
  Value<String?> foremanId,
  Value<String> crewListJson,
  Value<String?> crewHash,
  Value<DateTime> lastUpdated,
  Value<bool> synced,
  Value<int> rowid,
});

class $$JobsLocalTableFilterComposer
    extends Composer<_$AppDatabase, $JobsLocalTable> {
  $$JobsLocalTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get jobId => $composableBuilder(
      column: $table.jobId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get serviceId => $composableBuilder(
      column: $table.serviceId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get customerName => $composableBuilder(
      column: $table.customerName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get address => $composableBuilder(
      column: $table.address, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get scheduledDate => $composableBuilder(
      column: $table.scheduledDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get foremanId => $composableBuilder(
      column: $table.foremanId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get crewListJson => $composableBuilder(
      column: $table.crewListJson, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get crewHash => $composableBuilder(
      column: $table.crewHash, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastUpdated => $composableBuilder(
      column: $table.lastUpdated, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get synced => $composableBuilder(
      column: $table.synced, builder: (column) => ColumnFilters(column));
}

class $$JobsLocalTableOrderingComposer
    extends Composer<_$AppDatabase, $JobsLocalTable> {
  $$JobsLocalTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get jobId => $composableBuilder(
      column: $table.jobId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get serviceId => $composableBuilder(
      column: $table.serviceId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get customerName => $composableBuilder(
      column: $table.customerName,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get address => $composableBuilder(
      column: $table.address, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get scheduledDate => $composableBuilder(
      column: $table.scheduledDate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get foremanId => $composableBuilder(
      column: $table.foremanId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get crewListJson => $composableBuilder(
      column: $table.crewListJson,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get crewHash => $composableBuilder(
      column: $table.crewHash, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastUpdated => $composableBuilder(
      column: $table.lastUpdated, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get synced => $composableBuilder(
      column: $table.synced, builder: (column) => ColumnOrderings(column));
}

class $$JobsLocalTableAnnotationComposer
    extends Composer<_$AppDatabase, $JobsLocalTable> {
  $$JobsLocalTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get jobId =>
      $composableBuilder(column: $table.jobId, builder: (column) => column);

  GeneratedColumn<String> get serviceId =>
      $composableBuilder(column: $table.serviceId, builder: (column) => column);

  GeneratedColumn<String> get customerName => $composableBuilder(
      column: $table.customerName, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<DateTime> get scheduledDate => $composableBuilder(
      column: $table.scheduledDate, builder: (column) => column);

  GeneratedColumn<String> get foremanId =>
      $composableBuilder(column: $table.foremanId, builder: (column) => column);

  GeneratedColumn<String> get crewListJson => $composableBuilder(
      column: $table.crewListJson, builder: (column) => column);

  GeneratedColumn<String> get crewHash =>
      $composableBuilder(column: $table.crewHash, builder: (column) => column);

  GeneratedColumn<DateTime> get lastUpdated => $composableBuilder(
      column: $table.lastUpdated, builder: (column) => column);

  GeneratedColumn<bool> get synced =>
      $composableBuilder(column: $table.synced, builder: (column) => column);
}

class $$JobsLocalTableTableManager extends RootTableManager<
    _$AppDatabase,
    $JobsLocalTable,
    JobsLocalData,
    $$JobsLocalTableFilterComposer,
    $$JobsLocalTableOrderingComposer,
    $$JobsLocalTableAnnotationComposer,
    $$JobsLocalTableCreateCompanionBuilder,
    $$JobsLocalTableUpdateCompanionBuilder,
    (
      JobsLocalData,
      BaseReferences<_$AppDatabase, $JobsLocalTable, JobsLocalData>
    ),
    JobsLocalData,
    PrefetchHooks Function()> {
  $$JobsLocalTableTableManager(_$AppDatabase db, $JobsLocalTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$JobsLocalTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$JobsLocalTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$JobsLocalTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> jobId = const Value.absent(),
            Value<String> serviceId = const Value.absent(),
            Value<String> customerName = const Value.absent(),
            Value<String?> address = const Value.absent(),
            Value<DateTime> scheduledDate = const Value.absent(),
            Value<String?> foremanId = const Value.absent(),
            Value<String> crewListJson = const Value.absent(),
            Value<String?> crewHash = const Value.absent(),
            Value<DateTime> lastUpdated = const Value.absent(),
            Value<bool> synced = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              JobsLocalCompanion(
            jobId: jobId,
            serviceId: serviceId,
            customerName: customerName,
            address: address,
            scheduledDate: scheduledDate,
            foremanId: foremanId,
            crewListJson: crewListJson,
            crewHash: crewHash,
            lastUpdated: lastUpdated,
            synced: synced,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String jobId,
            required String serviceId,
            required String customerName,
            Value<String?> address = const Value.absent(),
            required DateTime scheduledDate,
            Value<String?> foremanId = const Value.absent(),
            Value<String> crewListJson = const Value.absent(),
            Value<String?> crewHash = const Value.absent(),
            Value<DateTime> lastUpdated = const Value.absent(),
            Value<bool> synced = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              JobsLocalCompanion.insert(
            jobId: jobId,
            serviceId: serviceId,
            customerName: customerName,
            address: address,
            scheduledDate: scheduledDate,
            foremanId: foremanId,
            crewListJson: crewListJson,
            crewHash: crewHash,
            lastUpdated: lastUpdated,
            synced: synced,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$JobsLocalTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $JobsLocalTable,
    JobsLocalData,
    $$JobsLocalTableFilterComposer,
    $$JobsLocalTableOrderingComposer,
    $$JobsLocalTableAnnotationComposer,
    $$JobsLocalTableCreateCompanionBuilder,
    $$JobsLocalTableUpdateCompanionBuilder,
    (
      JobsLocalData,
      BaseReferences<_$AppDatabase, $JobsLocalTable, JobsLocalData>
    ),
    JobsLocalData,
    PrefetchHooks Function()>;
typedef $$JobFeedStateLocalTableCreateCompanionBuilder
    = JobFeedStateLocalCompanion Function({
  required String employeeId,
  Value<DateTime?> rangeStart,
  Value<DateTime?> rangeEnd,
  Value<DateTime> lastRefreshed,
  Value<String?> apiVersion,
  Value<String?> nextCursor,
  Value<int> rowid,
});
typedef $$JobFeedStateLocalTableUpdateCompanionBuilder
    = JobFeedStateLocalCompanion Function({
  Value<String> employeeId,
  Value<DateTime?> rangeStart,
  Value<DateTime?> rangeEnd,
  Value<DateTime> lastRefreshed,
  Value<String?> apiVersion,
  Value<String?> nextCursor,
  Value<int> rowid,
});

class $$JobFeedStateLocalTableFilterComposer
    extends Composer<_$AppDatabase, $JobFeedStateLocalTable> {
  $$JobFeedStateLocalTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get employeeId => $composableBuilder(
      column: $table.employeeId, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get rangeStart => $composableBuilder(
      column: $table.rangeStart, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get rangeEnd => $composableBuilder(
      column: $table.rangeEnd, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastRefreshed => $composableBuilder(
      column: $table.lastRefreshed, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get apiVersion => $composableBuilder(
      column: $table.apiVersion, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nextCursor => $composableBuilder(
      column: $table.nextCursor, builder: (column) => ColumnFilters(column));
}

class $$JobFeedStateLocalTableOrderingComposer
    extends Composer<_$AppDatabase, $JobFeedStateLocalTable> {
  $$JobFeedStateLocalTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get employeeId => $composableBuilder(
      column: $table.employeeId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get rangeStart => $composableBuilder(
      column: $table.rangeStart, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get rangeEnd => $composableBuilder(
      column: $table.rangeEnd, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastRefreshed => $composableBuilder(
      column: $table.lastRefreshed,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get apiVersion => $composableBuilder(
      column: $table.apiVersion, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nextCursor => $composableBuilder(
      column: $table.nextCursor, builder: (column) => ColumnOrderings(column));
}

class $$JobFeedStateLocalTableAnnotationComposer
    extends Composer<_$AppDatabase, $JobFeedStateLocalTable> {
  $$JobFeedStateLocalTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get employeeId => $composableBuilder(
      column: $table.employeeId, builder: (column) => column);

  GeneratedColumn<DateTime> get rangeStart => $composableBuilder(
      column: $table.rangeStart, builder: (column) => column);

  GeneratedColumn<DateTime> get rangeEnd =>
      $composableBuilder(column: $table.rangeEnd, builder: (column) => column);

  GeneratedColumn<DateTime> get lastRefreshed => $composableBuilder(
      column: $table.lastRefreshed, builder: (column) => column);

  GeneratedColumn<String> get apiVersion => $composableBuilder(
      column: $table.apiVersion, builder: (column) => column);

  GeneratedColumn<String> get nextCursor => $composableBuilder(
      column: $table.nextCursor, builder: (column) => column);
}

class $$JobFeedStateLocalTableTableManager extends RootTableManager<
    _$AppDatabase,
    $JobFeedStateLocalTable,
    JobFeedStateLocalData,
    $$JobFeedStateLocalTableFilterComposer,
    $$JobFeedStateLocalTableOrderingComposer,
    $$JobFeedStateLocalTableAnnotationComposer,
    $$JobFeedStateLocalTableCreateCompanionBuilder,
    $$JobFeedStateLocalTableUpdateCompanionBuilder,
    (
      JobFeedStateLocalData,
      BaseReferences<_$AppDatabase, $JobFeedStateLocalTable,
          JobFeedStateLocalData>
    ),
    JobFeedStateLocalData,
    PrefetchHooks Function()> {
  $$JobFeedStateLocalTableTableManager(
      _$AppDatabase db, $JobFeedStateLocalTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$JobFeedStateLocalTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$JobFeedStateLocalTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$JobFeedStateLocalTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> employeeId = const Value.absent(),
            Value<DateTime?> rangeStart = const Value.absent(),
            Value<DateTime?> rangeEnd = const Value.absent(),
            Value<DateTime> lastRefreshed = const Value.absent(),
            Value<String?> apiVersion = const Value.absent(),
            Value<String?> nextCursor = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              JobFeedStateLocalCompanion(
            employeeId: employeeId,
            rangeStart: rangeStart,
            rangeEnd: rangeEnd,
            lastRefreshed: lastRefreshed,
            apiVersion: apiVersion,
            nextCursor: nextCursor,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String employeeId,
            Value<DateTime?> rangeStart = const Value.absent(),
            Value<DateTime?> rangeEnd = const Value.absent(),
            Value<DateTime> lastRefreshed = const Value.absent(),
            Value<String?> apiVersion = const Value.absent(),
            Value<String?> nextCursor = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              JobFeedStateLocalCompanion.insert(
            employeeId: employeeId,
            rangeStart: rangeStart,
            rangeEnd: rangeEnd,
            lastRefreshed: lastRefreshed,
            apiVersion: apiVersion,
            nextCursor: nextCursor,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$JobFeedStateLocalTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $JobFeedStateLocalTable,
    JobFeedStateLocalData,
    $$JobFeedStateLocalTableFilterComposer,
    $$JobFeedStateLocalTableOrderingComposer,
    $$JobFeedStateLocalTableAnnotationComposer,
    $$JobFeedStateLocalTableCreateCompanionBuilder,
    $$JobFeedStateLocalTableUpdateCompanionBuilder,
    (
      JobFeedStateLocalData,
      BaseReferences<_$AppDatabase, $JobFeedStateLocalTable,
          JobFeedStateLocalData>
    ),
    JobFeedStateLocalData,
    PrefetchHooks Function()>;
typedef $$ProfileLocalTableCreateCompanionBuilder = ProfileLocalCompanion
    Function({
  required String employeeId,
  required String displayName,
  Value<String?> email,
  Value<String?> phone,
  Value<String?> crew,
  Value<String?> role,
  Value<String?> deviceId,
  Value<String?> osVersion,
  Value<DateTime?> lastSync,
  Value<int> rowid,
});
typedef $$ProfileLocalTableUpdateCompanionBuilder = ProfileLocalCompanion
    Function({
  Value<String> employeeId,
  Value<String> displayName,
  Value<String?> email,
  Value<String?> phone,
  Value<String?> crew,
  Value<String?> role,
  Value<String?> deviceId,
  Value<String?> osVersion,
  Value<DateTime?> lastSync,
  Value<int> rowid,
});

class $$ProfileLocalTableFilterComposer
    extends Composer<_$AppDatabase, $ProfileLocalTable> {
  $$ProfileLocalTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get employeeId => $composableBuilder(
      column: $table.employeeId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get displayName => $composableBuilder(
      column: $table.displayName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get crew => $composableBuilder(
      column: $table.crew, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get role => $composableBuilder(
      column: $table.role, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get deviceId => $composableBuilder(
      column: $table.deviceId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get osVersion => $composableBuilder(
      column: $table.osVersion, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastSync => $composableBuilder(
      column: $table.lastSync, builder: (column) => ColumnFilters(column));
}

class $$ProfileLocalTableOrderingComposer
    extends Composer<_$AppDatabase, $ProfileLocalTable> {
  $$ProfileLocalTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get employeeId => $composableBuilder(
      column: $table.employeeId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get displayName => $composableBuilder(
      column: $table.displayName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get crew => $composableBuilder(
      column: $table.crew, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get role => $composableBuilder(
      column: $table.role, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get deviceId => $composableBuilder(
      column: $table.deviceId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get osVersion => $composableBuilder(
      column: $table.osVersion, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastSync => $composableBuilder(
      column: $table.lastSync, builder: (column) => ColumnOrderings(column));
}

class $$ProfileLocalTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProfileLocalTable> {
  $$ProfileLocalTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get employeeId => $composableBuilder(
      column: $table.employeeId, builder: (column) => column);

  GeneratedColumn<String> get displayName => $composableBuilder(
      column: $table.displayName, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get crew =>
      $composableBuilder(column: $table.crew, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<String> get deviceId =>
      $composableBuilder(column: $table.deviceId, builder: (column) => column);

  GeneratedColumn<String> get osVersion =>
      $composableBuilder(column: $table.osVersion, builder: (column) => column);

  GeneratedColumn<DateTime> get lastSync =>
      $composableBuilder(column: $table.lastSync, builder: (column) => column);
}

class $$ProfileLocalTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ProfileLocalTable,
    ProfileLocalData,
    $$ProfileLocalTableFilterComposer,
    $$ProfileLocalTableOrderingComposer,
    $$ProfileLocalTableAnnotationComposer,
    $$ProfileLocalTableCreateCompanionBuilder,
    $$ProfileLocalTableUpdateCompanionBuilder,
    (
      ProfileLocalData,
      BaseReferences<_$AppDatabase, $ProfileLocalTable, ProfileLocalData>
    ),
    ProfileLocalData,
    PrefetchHooks Function()> {
  $$ProfileLocalTableTableManager(_$AppDatabase db, $ProfileLocalTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProfileLocalTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProfileLocalTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProfileLocalTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> employeeId = const Value.absent(),
            Value<String> displayName = const Value.absent(),
            Value<String?> email = const Value.absent(),
            Value<String?> phone = const Value.absent(),
            Value<String?> crew = const Value.absent(),
            Value<String?> role = const Value.absent(),
            Value<String?> deviceId = const Value.absent(),
            Value<String?> osVersion = const Value.absent(),
            Value<DateTime?> lastSync = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ProfileLocalCompanion(
            employeeId: employeeId,
            displayName: displayName,
            email: email,
            phone: phone,
            crew: crew,
            role: role,
            deviceId: deviceId,
            osVersion: osVersion,
            lastSync: lastSync,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String employeeId,
            required String displayName,
            Value<String?> email = const Value.absent(),
            Value<String?> phone = const Value.absent(),
            Value<String?> crew = const Value.absent(),
            Value<String?> role = const Value.absent(),
            Value<String?> deviceId = const Value.absent(),
            Value<String?> osVersion = const Value.absent(),
            Value<DateTime?> lastSync = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ProfileLocalCompanion.insert(
            employeeId: employeeId,
            displayName: displayName,
            email: email,
            phone: phone,
            crew: crew,
            role: role,
            deviceId: deviceId,
            osVersion: osVersion,
            lastSync: lastSync,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ProfileLocalTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ProfileLocalTable,
    ProfileLocalData,
    $$ProfileLocalTableFilterComposer,
    $$ProfileLocalTableOrderingComposer,
    $$ProfileLocalTableAnnotationComposer,
    $$ProfileLocalTableCreateCompanionBuilder,
    $$ProfileLocalTableUpdateCompanionBuilder,
    (
      ProfileLocalData,
      BaseReferences<_$AppDatabase, $ProfileLocalTable, ProfileLocalData>
    ),
    ProfileLocalData,
    PrefetchHooks Function()>;
typedef $$SyncQueueTableCreateCompanionBuilder = SyncQueueCompanion Function({
  Value<int> id,
  required String entityType,
  required String payload,
  Value<int> attemptCount,
  Value<String?> lastError,
  Value<DateTime> createdAt,
  Value<DateTime?> lastAttemptAt,
  Value<String?> mobileUuid,
});
typedef $$SyncQueueTableUpdateCompanionBuilder = SyncQueueCompanion Function({
  Value<int> id,
  Value<String> entityType,
  Value<String> payload,
  Value<int> attemptCount,
  Value<String?> lastError,
  Value<DateTime> createdAt,
  Value<DateTime?> lastAttemptAt,
  Value<String?> mobileUuid,
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

  ColumnFilters<String> get entityType => $composableBuilder(
      column: $table.entityType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get payload => $composableBuilder(
      column: $table.payload, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get attemptCount => $composableBuilder(
      column: $table.attemptCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get lastError => $composableBuilder(
      column: $table.lastError, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastAttemptAt => $composableBuilder(
      column: $table.lastAttemptAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get mobileUuid => $composableBuilder(
      column: $table.mobileUuid, builder: (column) => ColumnFilters(column));
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

  ColumnOrderings<String> get entityType => $composableBuilder(
      column: $table.entityType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get payload => $composableBuilder(
      column: $table.payload, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get attemptCount => $composableBuilder(
      column: $table.attemptCount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get lastError => $composableBuilder(
      column: $table.lastError, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastAttemptAt => $composableBuilder(
      column: $table.lastAttemptAt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get mobileUuid => $composableBuilder(
      column: $table.mobileUuid, builder: (column) => ColumnOrderings(column));
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

  GeneratedColumn<String> get entityType => $composableBuilder(
      column: $table.entityType, builder: (column) => column);

  GeneratedColumn<String> get payload =>
      $composableBuilder(column: $table.payload, builder: (column) => column);

  GeneratedColumn<int> get attemptCount => $composableBuilder(
      column: $table.attemptCount, builder: (column) => column);

  GeneratedColumn<String> get lastError =>
      $composableBuilder(column: $table.lastError, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get lastAttemptAt => $composableBuilder(
      column: $table.lastAttemptAt, builder: (column) => column);

  GeneratedColumn<String> get mobileUuid => $composableBuilder(
      column: $table.mobileUuid, builder: (column) => column);
}

class $$SyncQueueTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SyncQueueTable,
    SyncQueueData,
    $$SyncQueueTableFilterComposer,
    $$SyncQueueTableOrderingComposer,
    $$SyncQueueTableAnnotationComposer,
    $$SyncQueueTableCreateCompanionBuilder,
    $$SyncQueueTableUpdateCompanionBuilder,
    (
      SyncQueueData,
      BaseReferences<_$AppDatabase, $SyncQueueTable, SyncQueueData>
    ),
    SyncQueueData,
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
            Value<String> entityType = const Value.absent(),
            Value<String> payload = const Value.absent(),
            Value<int> attemptCount = const Value.absent(),
            Value<String?> lastError = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> lastAttemptAt = const Value.absent(),
            Value<String?> mobileUuid = const Value.absent(),
          }) =>
              SyncQueueCompanion(
            id: id,
            entityType: entityType,
            payload: payload,
            attemptCount: attemptCount,
            lastError: lastError,
            createdAt: createdAt,
            lastAttemptAt: lastAttemptAt,
            mobileUuid: mobileUuid,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String entityType,
            required String payload,
            Value<int> attemptCount = const Value.absent(),
            Value<String?> lastError = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> lastAttemptAt = const Value.absent(),
            Value<String?> mobileUuid = const Value.absent(),
          }) =>
              SyncQueueCompanion.insert(
            id: id,
            entityType: entityType,
            payload: payload,
            attemptCount: attemptCount,
            lastError: lastError,
            createdAt: createdAt,
            lastAttemptAt: lastAttemptAt,
            mobileUuid: mobileUuid,
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
    SyncQueueData,
    $$SyncQueueTableFilterComposer,
    $$SyncQueueTableOrderingComposer,
    $$SyncQueueTableAnnotationComposer,
    $$SyncQueueTableCreateCompanionBuilder,
    $$SyncQueueTableUpdateCompanionBuilder,
    (
      SyncQueueData,
      BaseReferences<_$AppDatabase, $SyncQueueTable, SyncQueueData>
    ),
    SyncQueueData,
    PrefetchHooks Function()>;
typedef $$CorruptQueueEntriesTableCreateCompanionBuilder
    = CorruptQueueEntriesCompanion Function({
  Value<int> id,
  Value<int?> originalQueueId,
  Value<String?> entityType,
  Value<String?> payload,
  Value<String?> error,
  Value<DateTime> createdAt,
});
typedef $$CorruptQueueEntriesTableUpdateCompanionBuilder
    = CorruptQueueEntriesCompanion Function({
  Value<int> id,
  Value<int?> originalQueueId,
  Value<String?> entityType,
  Value<String?> payload,
  Value<String?> error,
  Value<DateTime> createdAt,
});

class $$CorruptQueueEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $CorruptQueueEntriesTable> {
  $$CorruptQueueEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get originalQueueId => $composableBuilder(
      column: $table.originalQueueId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get entityType => $composableBuilder(
      column: $table.entityType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get payload => $composableBuilder(
      column: $table.payload, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get error => $composableBuilder(
      column: $table.error, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$CorruptQueueEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $CorruptQueueEntriesTable> {
  $$CorruptQueueEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get originalQueueId => $composableBuilder(
      column: $table.originalQueueId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get entityType => $composableBuilder(
      column: $table.entityType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get payload => $composableBuilder(
      column: $table.payload, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get error => $composableBuilder(
      column: $table.error, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$CorruptQueueEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CorruptQueueEntriesTable> {
  $$CorruptQueueEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get originalQueueId => $composableBuilder(
      column: $table.originalQueueId, builder: (column) => column);

  GeneratedColumn<String> get entityType => $composableBuilder(
      column: $table.entityType, builder: (column) => column);

  GeneratedColumn<String> get payload =>
      $composableBuilder(column: $table.payload, builder: (column) => column);

  GeneratedColumn<String> get error =>
      $composableBuilder(column: $table.error, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$CorruptQueueEntriesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CorruptQueueEntriesTable,
    CorruptQueueEntry,
    $$CorruptQueueEntriesTableFilterComposer,
    $$CorruptQueueEntriesTableOrderingComposer,
    $$CorruptQueueEntriesTableAnnotationComposer,
    $$CorruptQueueEntriesTableCreateCompanionBuilder,
    $$CorruptQueueEntriesTableUpdateCompanionBuilder,
    (
      CorruptQueueEntry,
      BaseReferences<_$AppDatabase, $CorruptQueueEntriesTable,
          CorruptQueueEntry>
    ),
    CorruptQueueEntry,
    PrefetchHooks Function()> {
  $$CorruptQueueEntriesTableTableManager(
      _$AppDatabase db, $CorruptQueueEntriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CorruptQueueEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CorruptQueueEntriesTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CorruptQueueEntriesTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int?> originalQueueId = const Value.absent(),
            Value<String?> entityType = const Value.absent(),
            Value<String?> payload = const Value.absent(),
            Value<String?> error = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              CorruptQueueEntriesCompanion(
            id: id,
            originalQueueId: originalQueueId,
            entityType: entityType,
            payload: payload,
            error: error,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int?> originalQueueId = const Value.absent(),
            Value<String?> entityType = const Value.absent(),
            Value<String?> payload = const Value.absent(),
            Value<String?> error = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              CorruptQueueEntriesCompanion.insert(
            id: id,
            originalQueueId: originalQueueId,
            entityType: entityType,
            payload: payload,
            error: error,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$CorruptQueueEntriesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CorruptQueueEntriesTable,
    CorruptQueueEntry,
    $$CorruptQueueEntriesTableFilterComposer,
    $$CorruptQueueEntriesTableOrderingComposer,
    $$CorruptQueueEntriesTableAnnotationComposer,
    $$CorruptQueueEntriesTableCreateCompanionBuilder,
    $$CorruptQueueEntriesTableUpdateCompanionBuilder,
    (
      CorruptQueueEntry,
      BaseReferences<_$AppDatabase, $CorruptQueueEntriesTable,
          CorruptQueueEntry>
    ),
    CorruptQueueEntry,
    PrefetchHooks Function()>;
typedef $$TimesheetLocalTableCreateCompanionBuilder = TimesheetLocalCompanion
    Function({
  required String timesheetId,
  required String employeeId,
  required DateTime weekStart,
  required DateTime weekEnd,
  required DateTime date,
  required double regularHours,
  required double otHours,
  Value<String?> notes,
  required double weeklyTotalHours,
  required double weeklyOt1Hours,
  required double estimatedPay,
  Value<bool> synced,
  Value<bool> adjusted,
  Value<bool> flagged,
  Value<String?> disputeStatus,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});
typedef $$TimesheetLocalTableUpdateCompanionBuilder = TimesheetLocalCompanion
    Function({
  Value<String> timesheetId,
  Value<String> employeeId,
  Value<DateTime> weekStart,
  Value<DateTime> weekEnd,
  Value<DateTime> date,
  Value<double> regularHours,
  Value<double> otHours,
  Value<String?> notes,
  Value<double> weeklyTotalHours,
  Value<double> weeklyOt1Hours,
  Value<double> estimatedPay,
  Value<bool> synced,
  Value<bool> adjusted,
  Value<bool> flagged,
  Value<String?> disputeStatus,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$TimesheetLocalTableFilterComposer
    extends Composer<_$AppDatabase, $TimesheetLocalTable> {
  $$TimesheetLocalTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get timesheetId => $composableBuilder(
      column: $table.timesheetId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get employeeId => $composableBuilder(
      column: $table.employeeId, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get weekStart => $composableBuilder(
      column: $table.weekStart, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get weekEnd => $composableBuilder(
      column: $table.weekEnd, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get regularHours => $composableBuilder(
      column: $table.regularHours, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get otHours => $composableBuilder(
      column: $table.otHours, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get weeklyTotalHours => $composableBuilder(
      column: $table.weeklyTotalHours,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get weeklyOt1Hours => $composableBuilder(
      column: $table.weeklyOt1Hours,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get estimatedPay => $composableBuilder(
      column: $table.estimatedPay, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get synced => $composableBuilder(
      column: $table.synced, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get adjusted => $composableBuilder(
      column: $table.adjusted, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get flagged => $composableBuilder(
      column: $table.flagged, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get disputeStatus => $composableBuilder(
      column: $table.disputeStatus, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$TimesheetLocalTableOrderingComposer
    extends Composer<_$AppDatabase, $TimesheetLocalTable> {
  $$TimesheetLocalTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get timesheetId => $composableBuilder(
      column: $table.timesheetId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get employeeId => $composableBuilder(
      column: $table.employeeId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get weekStart => $composableBuilder(
      column: $table.weekStart, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get weekEnd => $composableBuilder(
      column: $table.weekEnd, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get regularHours => $composableBuilder(
      column: $table.regularHours,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get otHours => $composableBuilder(
      column: $table.otHours, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get weeklyTotalHours => $composableBuilder(
      column: $table.weeklyTotalHours,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get weeklyOt1Hours => $composableBuilder(
      column: $table.weeklyOt1Hours,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get estimatedPay => $composableBuilder(
      column: $table.estimatedPay,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get synced => $composableBuilder(
      column: $table.synced, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get adjusted => $composableBuilder(
      column: $table.adjusted, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get flagged => $composableBuilder(
      column: $table.flagged, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get disputeStatus => $composableBuilder(
      column: $table.disputeStatus,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$TimesheetLocalTableAnnotationComposer
    extends Composer<_$AppDatabase, $TimesheetLocalTable> {
  $$TimesheetLocalTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get timesheetId => $composableBuilder(
      column: $table.timesheetId, builder: (column) => column);

  GeneratedColumn<String> get employeeId => $composableBuilder(
      column: $table.employeeId, builder: (column) => column);

  GeneratedColumn<DateTime> get weekStart =>
      $composableBuilder(column: $table.weekStart, builder: (column) => column);

  GeneratedColumn<DateTime> get weekEnd =>
      $composableBuilder(column: $table.weekEnd, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<double> get regularHours => $composableBuilder(
      column: $table.regularHours, builder: (column) => column);

  GeneratedColumn<double> get otHours =>
      $composableBuilder(column: $table.otHours, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<double> get weeklyTotalHours => $composableBuilder(
      column: $table.weeklyTotalHours, builder: (column) => column);

  GeneratedColumn<double> get weeklyOt1Hours => $composableBuilder(
      column: $table.weeklyOt1Hours, builder: (column) => column);

  GeneratedColumn<double> get estimatedPay => $composableBuilder(
      column: $table.estimatedPay, builder: (column) => column);

  GeneratedColumn<bool> get synced =>
      $composableBuilder(column: $table.synced, builder: (column) => column);

  GeneratedColumn<bool> get adjusted =>
      $composableBuilder(column: $table.adjusted, builder: (column) => column);

  GeneratedColumn<bool> get flagged =>
      $composableBuilder(column: $table.flagged, builder: (column) => column);

  GeneratedColumn<String> get disputeStatus => $composableBuilder(
      column: $table.disputeStatus, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$TimesheetLocalTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TimesheetLocalTable,
    TimesheetLocalData,
    $$TimesheetLocalTableFilterComposer,
    $$TimesheetLocalTableOrderingComposer,
    $$TimesheetLocalTableAnnotationComposer,
    $$TimesheetLocalTableCreateCompanionBuilder,
    $$TimesheetLocalTableUpdateCompanionBuilder,
    (
      TimesheetLocalData,
      BaseReferences<_$AppDatabase, $TimesheetLocalTable, TimesheetLocalData>
    ),
    TimesheetLocalData,
    PrefetchHooks Function()> {
  $$TimesheetLocalTableTableManager(
      _$AppDatabase db, $TimesheetLocalTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TimesheetLocalTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TimesheetLocalTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TimesheetLocalTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> timesheetId = const Value.absent(),
            Value<String> employeeId = const Value.absent(),
            Value<DateTime> weekStart = const Value.absent(),
            Value<DateTime> weekEnd = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<double> regularHours = const Value.absent(),
            Value<double> otHours = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<double> weeklyTotalHours = const Value.absent(),
            Value<double> weeklyOt1Hours = const Value.absent(),
            Value<double> estimatedPay = const Value.absent(),
            Value<bool> synced = const Value.absent(),
            Value<bool> adjusted = const Value.absent(),
            Value<bool> flagged = const Value.absent(),
            Value<String?> disputeStatus = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TimesheetLocalCompanion(
            timesheetId: timesheetId,
            employeeId: employeeId,
            weekStart: weekStart,
            weekEnd: weekEnd,
            date: date,
            regularHours: regularHours,
            otHours: otHours,
            notes: notes,
            weeklyTotalHours: weeklyTotalHours,
            weeklyOt1Hours: weeklyOt1Hours,
            estimatedPay: estimatedPay,
            synced: synced,
            adjusted: adjusted,
            flagged: flagged,
            disputeStatus: disputeStatus,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String timesheetId,
            required String employeeId,
            required DateTime weekStart,
            required DateTime weekEnd,
            required DateTime date,
            required double regularHours,
            required double otHours,
            Value<String?> notes = const Value.absent(),
            required double weeklyTotalHours,
            required double weeklyOt1Hours,
            required double estimatedPay,
            Value<bool> synced = const Value.absent(),
            Value<bool> adjusted = const Value.absent(),
            Value<bool> flagged = const Value.absent(),
            Value<String?> disputeStatus = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TimesheetLocalCompanion.insert(
            timesheetId: timesheetId,
            employeeId: employeeId,
            weekStart: weekStart,
            weekEnd: weekEnd,
            date: date,
            regularHours: regularHours,
            otHours: otHours,
            notes: notes,
            weeklyTotalHours: weeklyTotalHours,
            weeklyOt1Hours: weeklyOt1Hours,
            estimatedPay: estimatedPay,
            synced: synced,
            adjusted: adjusted,
            flagged: flagged,
            disputeStatus: disputeStatus,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$TimesheetLocalTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TimesheetLocalTable,
    TimesheetLocalData,
    $$TimesheetLocalTableFilterComposer,
    $$TimesheetLocalTableOrderingComposer,
    $$TimesheetLocalTableAnnotationComposer,
    $$TimesheetLocalTableCreateCompanionBuilder,
    $$TimesheetLocalTableUpdateCompanionBuilder,
    (
      TimesheetLocalData,
      BaseReferences<_$AppDatabase, $TimesheetLocalTable, TimesheetLocalData>
    ),
    TimesheetLocalData,
    PrefetchHooks Function()>;
typedef $$SyncStateLocalTableCreateCompanionBuilder = SyncStateLocalCompanion
    Function({
  required String key,
  Value<DateTime?> lastSyncedAt,
  Value<DateTime?> lastRebuildAt,
  Value<String> status,
  Value<String?> lastError,
  Value<int> rowid,
});
typedef $$SyncStateLocalTableUpdateCompanionBuilder = SyncStateLocalCompanion
    Function({
  Value<String> key,
  Value<DateTime?> lastSyncedAt,
  Value<DateTime?> lastRebuildAt,
  Value<String> status,
  Value<String?> lastError,
  Value<int> rowid,
});

class $$SyncStateLocalTableFilterComposer
    extends Composer<_$AppDatabase, $SyncStateLocalTable> {
  $$SyncStateLocalTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
      column: $table.key, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastSyncedAt => $composableBuilder(
      column: $table.lastSyncedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastRebuildAt => $composableBuilder(
      column: $table.lastRebuildAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get lastError => $composableBuilder(
      column: $table.lastError, builder: (column) => ColumnFilters(column));
}

class $$SyncStateLocalTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncStateLocalTable> {
  $$SyncStateLocalTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
      column: $table.key, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastSyncedAt => $composableBuilder(
      column: $table.lastSyncedAt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastRebuildAt => $composableBuilder(
      column: $table.lastRebuildAt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get lastError => $composableBuilder(
      column: $table.lastError, builder: (column) => ColumnOrderings(column));
}

class $$SyncStateLocalTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncStateLocalTable> {
  $$SyncStateLocalTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<DateTime> get lastSyncedAt => $composableBuilder(
      column: $table.lastSyncedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get lastRebuildAt => $composableBuilder(
      column: $table.lastRebuildAt, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get lastError =>
      $composableBuilder(column: $table.lastError, builder: (column) => column);
}

class $$SyncStateLocalTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SyncStateLocalTable,
    SyncStateLocalData,
    $$SyncStateLocalTableFilterComposer,
    $$SyncStateLocalTableOrderingComposer,
    $$SyncStateLocalTableAnnotationComposer,
    $$SyncStateLocalTableCreateCompanionBuilder,
    $$SyncStateLocalTableUpdateCompanionBuilder,
    (
      SyncStateLocalData,
      BaseReferences<_$AppDatabase, $SyncStateLocalTable, SyncStateLocalData>
    ),
    SyncStateLocalData,
    PrefetchHooks Function()> {
  $$SyncStateLocalTableTableManager(
      _$AppDatabase db, $SyncStateLocalTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncStateLocalTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncStateLocalTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncStateLocalTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> key = const Value.absent(),
            Value<DateTime?> lastSyncedAt = const Value.absent(),
            Value<DateTime?> lastRebuildAt = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<String?> lastError = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SyncStateLocalCompanion(
            key: key,
            lastSyncedAt: lastSyncedAt,
            lastRebuildAt: lastRebuildAt,
            status: status,
            lastError: lastError,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String key,
            Value<DateTime?> lastSyncedAt = const Value.absent(),
            Value<DateTime?> lastRebuildAt = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<String?> lastError = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SyncStateLocalCompanion.insert(
            key: key,
            lastSyncedAt: lastSyncedAt,
            lastRebuildAt: lastRebuildAt,
            status: status,
            lastError: lastError,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SyncStateLocalTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SyncStateLocalTable,
    SyncStateLocalData,
    $$SyncStateLocalTableFilterComposer,
    $$SyncStateLocalTableOrderingComposer,
    $$SyncStateLocalTableAnnotationComposer,
    $$SyncStateLocalTableCreateCompanionBuilder,
    $$SyncStateLocalTableUpdateCompanionBuilder,
    (
      SyncStateLocalData,
      BaseReferences<_$AppDatabase, $SyncStateLocalTable, SyncStateLocalData>
    ),
    SyncStateLocalData,
    PrefetchHooks Function()>;
typedef $$TimesheetRollupsLocalTableCreateCompanionBuilder
    = TimesheetRollupsLocalCompanion Function({
  required String employeeId,
  required DateTime weekStart,
  required double totalHours,
  required double regularHours,
  required double otHours,
  required String hash,
  Value<DateTime> lastCalculatedAt,
  Value<int> rowid,
});
typedef $$TimesheetRollupsLocalTableUpdateCompanionBuilder
    = TimesheetRollupsLocalCompanion Function({
  Value<String> employeeId,
  Value<DateTime> weekStart,
  Value<double> totalHours,
  Value<double> regularHours,
  Value<double> otHours,
  Value<String> hash,
  Value<DateTime> lastCalculatedAt,
  Value<int> rowid,
});

class $$TimesheetRollupsLocalTableFilterComposer
    extends Composer<_$AppDatabase, $TimesheetRollupsLocalTable> {
  $$TimesheetRollupsLocalTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get employeeId => $composableBuilder(
      column: $table.employeeId, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get weekStart => $composableBuilder(
      column: $table.weekStart, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get totalHours => $composableBuilder(
      column: $table.totalHours, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get regularHours => $composableBuilder(
      column: $table.regularHours, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get otHours => $composableBuilder(
      column: $table.otHours, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get hash => $composableBuilder(
      column: $table.hash, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastCalculatedAt => $composableBuilder(
      column: $table.lastCalculatedAt,
      builder: (column) => ColumnFilters(column));
}

class $$TimesheetRollupsLocalTableOrderingComposer
    extends Composer<_$AppDatabase, $TimesheetRollupsLocalTable> {
  $$TimesheetRollupsLocalTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get employeeId => $composableBuilder(
      column: $table.employeeId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get weekStart => $composableBuilder(
      column: $table.weekStart, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get totalHours => $composableBuilder(
      column: $table.totalHours, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get regularHours => $composableBuilder(
      column: $table.regularHours,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get otHours => $composableBuilder(
      column: $table.otHours, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get hash => $composableBuilder(
      column: $table.hash, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastCalculatedAt => $composableBuilder(
      column: $table.lastCalculatedAt,
      builder: (column) => ColumnOrderings(column));
}

class $$TimesheetRollupsLocalTableAnnotationComposer
    extends Composer<_$AppDatabase, $TimesheetRollupsLocalTable> {
  $$TimesheetRollupsLocalTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get employeeId => $composableBuilder(
      column: $table.employeeId, builder: (column) => column);

  GeneratedColumn<DateTime> get weekStart =>
      $composableBuilder(column: $table.weekStart, builder: (column) => column);

  GeneratedColumn<double> get totalHours => $composableBuilder(
      column: $table.totalHours, builder: (column) => column);

  GeneratedColumn<double> get regularHours => $composableBuilder(
      column: $table.regularHours, builder: (column) => column);

  GeneratedColumn<double> get otHours =>
      $composableBuilder(column: $table.otHours, builder: (column) => column);

  GeneratedColumn<String> get hash =>
      $composableBuilder(column: $table.hash, builder: (column) => column);

  GeneratedColumn<DateTime> get lastCalculatedAt => $composableBuilder(
      column: $table.lastCalculatedAt, builder: (column) => column);
}

class $$TimesheetRollupsLocalTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TimesheetRollupsLocalTable,
    TimesheetRollupsLocalData,
    $$TimesheetRollupsLocalTableFilterComposer,
    $$TimesheetRollupsLocalTableOrderingComposer,
    $$TimesheetRollupsLocalTableAnnotationComposer,
    $$TimesheetRollupsLocalTableCreateCompanionBuilder,
    $$TimesheetRollupsLocalTableUpdateCompanionBuilder,
    (
      TimesheetRollupsLocalData,
      BaseReferences<_$AppDatabase, $TimesheetRollupsLocalTable,
          TimesheetRollupsLocalData>
    ),
    TimesheetRollupsLocalData,
    PrefetchHooks Function()> {
  $$TimesheetRollupsLocalTableTableManager(
      _$AppDatabase db, $TimesheetRollupsLocalTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TimesheetRollupsLocalTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$TimesheetRollupsLocalTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TimesheetRollupsLocalTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> employeeId = const Value.absent(),
            Value<DateTime> weekStart = const Value.absent(),
            Value<double> totalHours = const Value.absent(),
            Value<double> regularHours = const Value.absent(),
            Value<double> otHours = const Value.absent(),
            Value<String> hash = const Value.absent(),
            Value<DateTime> lastCalculatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TimesheetRollupsLocalCompanion(
            employeeId: employeeId,
            weekStart: weekStart,
            totalHours: totalHours,
            regularHours: regularHours,
            otHours: otHours,
            hash: hash,
            lastCalculatedAt: lastCalculatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String employeeId,
            required DateTime weekStart,
            required double totalHours,
            required double regularHours,
            required double otHours,
            required String hash,
            Value<DateTime> lastCalculatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TimesheetRollupsLocalCompanion.insert(
            employeeId: employeeId,
            weekStart: weekStart,
            totalHours: totalHours,
            regularHours: regularHours,
            otHours: otHours,
            hash: hash,
            lastCalculatedAt: lastCalculatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$TimesheetRollupsLocalTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $TimesheetRollupsLocalTable,
        TimesheetRollupsLocalData,
        $$TimesheetRollupsLocalTableFilterComposer,
        $$TimesheetRollupsLocalTableOrderingComposer,
        $$TimesheetRollupsLocalTableAnnotationComposer,
        $$TimesheetRollupsLocalTableCreateCompanionBuilder,
        $$TimesheetRollupsLocalTableUpdateCompanionBuilder,
        (
          TimesheetRollupsLocalData,
          BaseReferences<_$AppDatabase, $TimesheetRollupsLocalTable,
              TimesheetRollupsLocalData>
        ),
        TimesheetRollupsLocalData,
        PrefetchHooks Function()>;
typedef $$MissingJobLinksTableCreateCompanionBuilder = MissingJobLinksCompanion
    Function({
  required String punchId,
  required String jobId,
  Value<DateTime> detectedAt,
  Value<int> fetchAttempts,
  Value<DateTime?> lastFetchAttempt,
  Value<int> rowid,
});
typedef $$MissingJobLinksTableUpdateCompanionBuilder = MissingJobLinksCompanion
    Function({
  Value<String> punchId,
  Value<String> jobId,
  Value<DateTime> detectedAt,
  Value<int> fetchAttempts,
  Value<DateTime?> lastFetchAttempt,
  Value<int> rowid,
});

class $$MissingJobLinksTableFilterComposer
    extends Composer<_$AppDatabase, $MissingJobLinksTable> {
  $$MissingJobLinksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get punchId => $composableBuilder(
      column: $table.punchId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get jobId => $composableBuilder(
      column: $table.jobId, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get detectedAt => $composableBuilder(
      column: $table.detectedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get fetchAttempts => $composableBuilder(
      column: $table.fetchAttempts, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastFetchAttempt => $composableBuilder(
      column: $table.lastFetchAttempt,
      builder: (column) => ColumnFilters(column));
}

class $$MissingJobLinksTableOrderingComposer
    extends Composer<_$AppDatabase, $MissingJobLinksTable> {
  $$MissingJobLinksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get punchId => $composableBuilder(
      column: $table.punchId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get jobId => $composableBuilder(
      column: $table.jobId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get detectedAt => $composableBuilder(
      column: $table.detectedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get fetchAttempts => $composableBuilder(
      column: $table.fetchAttempts,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastFetchAttempt => $composableBuilder(
      column: $table.lastFetchAttempt,
      builder: (column) => ColumnOrderings(column));
}

class $$MissingJobLinksTableAnnotationComposer
    extends Composer<_$AppDatabase, $MissingJobLinksTable> {
  $$MissingJobLinksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get punchId =>
      $composableBuilder(column: $table.punchId, builder: (column) => column);

  GeneratedColumn<String> get jobId =>
      $composableBuilder(column: $table.jobId, builder: (column) => column);

  GeneratedColumn<DateTime> get detectedAt => $composableBuilder(
      column: $table.detectedAt, builder: (column) => column);

  GeneratedColumn<int> get fetchAttempts => $composableBuilder(
      column: $table.fetchAttempts, builder: (column) => column);

  GeneratedColumn<DateTime> get lastFetchAttempt => $composableBuilder(
      column: $table.lastFetchAttempt, builder: (column) => column);
}

class $$MissingJobLinksTableTableManager extends RootTableManager<
    _$AppDatabase,
    $MissingJobLinksTable,
    MissingJobLink,
    $$MissingJobLinksTableFilterComposer,
    $$MissingJobLinksTableOrderingComposer,
    $$MissingJobLinksTableAnnotationComposer,
    $$MissingJobLinksTableCreateCompanionBuilder,
    $$MissingJobLinksTableUpdateCompanionBuilder,
    (
      MissingJobLink,
      BaseReferences<_$AppDatabase, $MissingJobLinksTable, MissingJobLink>
    ),
    MissingJobLink,
    PrefetchHooks Function()> {
  $$MissingJobLinksTableTableManager(
      _$AppDatabase db, $MissingJobLinksTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MissingJobLinksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MissingJobLinksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MissingJobLinksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> punchId = const Value.absent(),
            Value<String> jobId = const Value.absent(),
            Value<DateTime> detectedAt = const Value.absent(),
            Value<int> fetchAttempts = const Value.absent(),
            Value<DateTime?> lastFetchAttempt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              MissingJobLinksCompanion(
            punchId: punchId,
            jobId: jobId,
            detectedAt: detectedAt,
            fetchAttempts: fetchAttempts,
            lastFetchAttempt: lastFetchAttempt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String punchId,
            required String jobId,
            Value<DateTime> detectedAt = const Value.absent(),
            Value<int> fetchAttempts = const Value.absent(),
            Value<DateTime?> lastFetchAttempt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              MissingJobLinksCompanion.insert(
            punchId: punchId,
            jobId: jobId,
            detectedAt: detectedAt,
            fetchAttempts: fetchAttempts,
            lastFetchAttempt: lastFetchAttempt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$MissingJobLinksTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $MissingJobLinksTable,
    MissingJobLink,
    $$MissingJobLinksTableFilterComposer,
    $$MissingJobLinksTableOrderingComposer,
    $$MissingJobLinksTableAnnotationComposer,
    $$MissingJobLinksTableCreateCompanionBuilder,
    $$MissingJobLinksTableUpdateCompanionBuilder,
    (
      MissingJobLink,
      BaseReferences<_$AppDatabase, $MissingJobLinksTable, MissingJobLink>
    ),
    MissingJobLink,
    PrefetchHooks Function()>;
typedef $$TimesheetFlagsLocalTableCreateCompanionBuilder
    = TimesheetFlagsLocalCompanion Function({
  required String flagId,
  Value<String?> punchId,
  Value<String?> timesheetId,
  required String employeeId,
  required DateTime date,
  required String code,
  required String message,
  required String severity,
  Value<bool> resolved,
  Value<DateTime> createdAt,
  Value<int> rowid,
});
typedef $$TimesheetFlagsLocalTableUpdateCompanionBuilder
    = TimesheetFlagsLocalCompanion Function({
  Value<String> flagId,
  Value<String?> punchId,
  Value<String?> timesheetId,
  Value<String> employeeId,
  Value<DateTime> date,
  Value<String> code,
  Value<String> message,
  Value<String> severity,
  Value<bool> resolved,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$TimesheetFlagsLocalTableFilterComposer
    extends Composer<_$AppDatabase, $TimesheetFlagsLocalTable> {
  $$TimesheetFlagsLocalTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get flagId => $composableBuilder(
      column: $table.flagId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get punchId => $composableBuilder(
      column: $table.punchId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get timesheetId => $composableBuilder(
      column: $table.timesheetId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get employeeId => $composableBuilder(
      column: $table.employeeId, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get code => $composableBuilder(
      column: $table.code, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get message => $composableBuilder(
      column: $table.message, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get severity => $composableBuilder(
      column: $table.severity, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get resolved => $composableBuilder(
      column: $table.resolved, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$TimesheetFlagsLocalTableOrderingComposer
    extends Composer<_$AppDatabase, $TimesheetFlagsLocalTable> {
  $$TimesheetFlagsLocalTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get flagId => $composableBuilder(
      column: $table.flagId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get punchId => $composableBuilder(
      column: $table.punchId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get timesheetId => $composableBuilder(
      column: $table.timesheetId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get employeeId => $composableBuilder(
      column: $table.employeeId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get code => $composableBuilder(
      column: $table.code, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get message => $composableBuilder(
      column: $table.message, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get severity => $composableBuilder(
      column: $table.severity, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get resolved => $composableBuilder(
      column: $table.resolved, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$TimesheetFlagsLocalTableAnnotationComposer
    extends Composer<_$AppDatabase, $TimesheetFlagsLocalTable> {
  $$TimesheetFlagsLocalTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get flagId =>
      $composableBuilder(column: $table.flagId, builder: (column) => column);

  GeneratedColumn<String> get punchId =>
      $composableBuilder(column: $table.punchId, builder: (column) => column);

  GeneratedColumn<String> get timesheetId => $composableBuilder(
      column: $table.timesheetId, builder: (column) => column);

  GeneratedColumn<String> get employeeId => $composableBuilder(
      column: $table.employeeId, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get message =>
      $composableBuilder(column: $table.message, builder: (column) => column);

  GeneratedColumn<String> get severity =>
      $composableBuilder(column: $table.severity, builder: (column) => column);

  GeneratedColumn<bool> get resolved =>
      $composableBuilder(column: $table.resolved, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$TimesheetFlagsLocalTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TimesheetFlagsLocalTable,
    TimesheetFlagsLocalData,
    $$TimesheetFlagsLocalTableFilterComposer,
    $$TimesheetFlagsLocalTableOrderingComposer,
    $$TimesheetFlagsLocalTableAnnotationComposer,
    $$TimesheetFlagsLocalTableCreateCompanionBuilder,
    $$TimesheetFlagsLocalTableUpdateCompanionBuilder,
    (
      TimesheetFlagsLocalData,
      BaseReferences<_$AppDatabase, $TimesheetFlagsLocalTable,
          TimesheetFlagsLocalData>
    ),
    TimesheetFlagsLocalData,
    PrefetchHooks Function()> {
  $$TimesheetFlagsLocalTableTableManager(
      _$AppDatabase db, $TimesheetFlagsLocalTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TimesheetFlagsLocalTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TimesheetFlagsLocalTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TimesheetFlagsLocalTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> flagId = const Value.absent(),
            Value<String?> punchId = const Value.absent(),
            Value<String?> timesheetId = const Value.absent(),
            Value<String> employeeId = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<String> code = const Value.absent(),
            Value<String> message = const Value.absent(),
            Value<String> severity = const Value.absent(),
            Value<bool> resolved = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TimesheetFlagsLocalCompanion(
            flagId: flagId,
            punchId: punchId,
            timesheetId: timesheetId,
            employeeId: employeeId,
            date: date,
            code: code,
            message: message,
            severity: severity,
            resolved: resolved,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String flagId,
            Value<String?> punchId = const Value.absent(),
            Value<String?> timesheetId = const Value.absent(),
            required String employeeId,
            required DateTime date,
            required String code,
            required String message,
            required String severity,
            Value<bool> resolved = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TimesheetFlagsLocalCompanion.insert(
            flagId: flagId,
            punchId: punchId,
            timesheetId: timesheetId,
            employeeId: employeeId,
            date: date,
            code: code,
            message: message,
            severity: severity,
            resolved: resolved,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$TimesheetFlagsLocalTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TimesheetFlagsLocalTable,
    TimesheetFlagsLocalData,
    $$TimesheetFlagsLocalTableFilterComposer,
    $$TimesheetFlagsLocalTableOrderingComposer,
    $$TimesheetFlagsLocalTableAnnotationComposer,
    $$TimesheetFlagsLocalTableCreateCompanionBuilder,
    $$TimesheetFlagsLocalTableUpdateCompanionBuilder,
    (
      TimesheetFlagsLocalData,
      BaseReferences<_$AppDatabase, $TimesheetFlagsLocalTable,
          TimesheetFlagsLocalData>
    ),
    TimesheetFlagsLocalData,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$PunchesLocalTableTableManager get punchesLocal =>
      $$PunchesLocalTableTableManager(_db, _db.punchesLocal);
  $$JobsLocalTableTableManager get jobsLocal =>
      $$JobsLocalTableTableManager(_db, _db.jobsLocal);
  $$JobFeedStateLocalTableTableManager get jobFeedStateLocal =>
      $$JobFeedStateLocalTableTableManager(_db, _db.jobFeedStateLocal);
  $$ProfileLocalTableTableManager get profileLocal =>
      $$ProfileLocalTableTableManager(_db, _db.profileLocal);
  $$SyncQueueTableTableManager get syncQueue =>
      $$SyncQueueTableTableManager(_db, _db.syncQueue);
  $$CorruptQueueEntriesTableTableManager get corruptQueueEntries =>
      $$CorruptQueueEntriesTableTableManager(_db, _db.corruptQueueEntries);
  $$TimesheetLocalTableTableManager get timesheetLocal =>
      $$TimesheetLocalTableTableManager(_db, _db.timesheetLocal);
  $$SyncStateLocalTableTableManager get syncStateLocal =>
      $$SyncStateLocalTableTableManager(_db, _db.syncStateLocal);
  $$TimesheetRollupsLocalTableTableManager get timesheetRollupsLocal =>
      $$TimesheetRollupsLocalTableTableManager(_db, _db.timesheetRollupsLocal);
  $$MissingJobLinksTableTableManager get missingJobLinks =>
      $$MissingJobLinksTableTableManager(_db, _db.missingJobLinks);
  $$TimesheetFlagsLocalTableTableManager get timesheetFlagsLocal =>
      $$TimesheetFlagsLocalTableTableManager(_db, _db.timesheetFlagsLocal);
}
