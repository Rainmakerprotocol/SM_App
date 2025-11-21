// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $PunchesLocalTable extends PunchesLocal
    with TableInfo<$PunchesLocalTable, PunchesLocalData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PunchesLocalTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _punchIdMeta = const VerificationMeta(
    'punchId',
  );
  @override
  late final GeneratedColumn<String> punchId = GeneratedColumn<String>(
    'punch_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _employeeIdMeta = const VerificationMeta(
    'employeeId',
  );
  @override
  late final GeneratedColumn<String> employeeId = GeneratedColumn<String>(
    'employee_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _jobIdMeta = const VerificationMeta('jobId');
  @override
  late final GeneratedColumn<String> jobId = GeneratedColumn<String>(
    'job_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _serviceIdMeta = const VerificationMeta(
    'serviceId',
  );
  @override
  late final GeneratedColumn<String> serviceId = GeneratedColumn<String>(
    'service_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _punchTypeMeta = const VerificationMeta(
    'punchType',
  );
  @override
  late final GeneratedColumn<String> punchType = GeneratedColumn<String>(
    'punch_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timestampDeviceMeta = const VerificationMeta(
    'timestampDevice',
  );
  @override
  late final GeneratedColumn<DateTime> timestampDevice =
      GeneratedColumn<DateTime>(
        'timestamp_device',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _gpsLatMeta = const VerificationMeta('gpsLat');
  @override
  late final GeneratedColumn<double> gpsLat = GeneratedColumn<double>(
    'gps_lat',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _gpsLngMeta = const VerificationMeta('gpsLng');
  @override
  late final GeneratedColumn<double> gpsLng = GeneratedColumn<double>(
    'gps_lng',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _gpsAccuracyMeta = const VerificationMeta(
    'gpsAccuracy',
  );
  @override
  late final GeneratedColumn<double> gpsAccuracy = GeneratedColumn<double>(
    'gps_accuracy',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _gpsUnavailableMeta = const VerificationMeta(
    'gpsUnavailable',
  );
  @override
  late final GeneratedColumn<bool> gpsUnavailable = GeneratedColumn<bool>(
    'gps_unavailable',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("gps_unavailable" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _syncedMeta = const VerificationMeta('synced');
  @override
  late final GeneratedColumn<bool> synced = GeneratedColumn<bool>(
    'synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("synced" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _syncAttemptsMeta = const VerificationMeta(
    'syncAttempts',
  );
  @override
  late final GeneratedColumn<int> syncAttempts = GeneratedColumn<int>(
    'sync_attempts',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('mobile_app'),
  );
  static const VerificationMeta _deviceIdMeta = const VerificationMeta(
    'deviceId',
  );
  @override
  late final GeneratedColumn<String> deviceId = GeneratedColumn<String>(
    'device_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastErrorMeta = const VerificationMeta(
    'lastError',
  );
  @override
  late final GeneratedColumn<String> lastError = GeneratedColumn<String>(
    'last_error',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _requiresDisputeMeta = const VerificationMeta(
    'requiresDispute',
  );
  @override
  late final GeneratedColumn<bool> requiresDispute = GeneratedColumn<bool>(
    'requires_dispute',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("requires_dispute" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
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
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'punches_local';
  @override
  VerificationContext validateIntegrity(
    Insertable<PunchesLocalData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('punch_id')) {
      context.handle(
        _punchIdMeta,
        punchId.isAcceptableOrUnknown(data['punch_id']!, _punchIdMeta),
      );
    } else if (isInserting) {
      context.missing(_punchIdMeta);
    }
    if (data.containsKey('employee_id')) {
      context.handle(
        _employeeIdMeta,
        employeeId.isAcceptableOrUnknown(data['employee_id']!, _employeeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_employeeIdMeta);
    }
    if (data.containsKey('job_id')) {
      context.handle(
        _jobIdMeta,
        jobId.isAcceptableOrUnknown(data['job_id']!, _jobIdMeta),
      );
    } else if (isInserting) {
      context.missing(_jobIdMeta);
    }
    if (data.containsKey('service_id')) {
      context.handle(
        _serviceIdMeta,
        serviceId.isAcceptableOrUnknown(data['service_id']!, _serviceIdMeta),
      );
    }
    if (data.containsKey('punch_type')) {
      context.handle(
        _punchTypeMeta,
        punchType.isAcceptableOrUnknown(data['punch_type']!, _punchTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_punchTypeMeta);
    }
    if (data.containsKey('timestamp_device')) {
      context.handle(
        _timestampDeviceMeta,
        timestampDevice.isAcceptableOrUnknown(
          data['timestamp_device']!,
          _timestampDeviceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_timestampDeviceMeta);
    }
    if (data.containsKey('gps_lat')) {
      context.handle(
        _gpsLatMeta,
        gpsLat.isAcceptableOrUnknown(data['gps_lat']!, _gpsLatMeta),
      );
    }
    if (data.containsKey('gps_lng')) {
      context.handle(
        _gpsLngMeta,
        gpsLng.isAcceptableOrUnknown(data['gps_lng']!, _gpsLngMeta),
      );
    }
    if (data.containsKey('gps_accuracy')) {
      context.handle(
        _gpsAccuracyMeta,
        gpsAccuracy.isAcceptableOrUnknown(
          data['gps_accuracy']!,
          _gpsAccuracyMeta,
        ),
      );
    }
    if (data.containsKey('gps_unavailable')) {
      context.handle(
        _gpsUnavailableMeta,
        gpsUnavailable.isAcceptableOrUnknown(
          data['gps_unavailable']!,
          _gpsUnavailableMeta,
        ),
      );
    }
    if (data.containsKey('synced')) {
      context.handle(
        _syncedMeta,
        synced.isAcceptableOrUnknown(data['synced']!, _syncedMeta),
      );
    }
    if (data.containsKey('sync_attempts')) {
      context.handle(
        _syncAttemptsMeta,
        syncAttempts.isAcceptableOrUnknown(
          data['sync_attempts']!,
          _syncAttemptsMeta,
        ),
      );
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    }
    if (data.containsKey('device_id')) {
      context.handle(
        _deviceIdMeta,
        deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta),
      );
    }
    if (data.containsKey('last_error')) {
      context.handle(
        _lastErrorMeta,
        lastError.isAcceptableOrUnknown(data['last_error']!, _lastErrorMeta),
      );
    }
    if (data.containsKey('requires_dispute')) {
      context.handle(
        _requiresDisputeMeta,
        requiresDispute.isAcceptableOrUnknown(
          data['requires_dispute']!,
          _requiresDisputeMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {punchId};
  @override
  PunchesLocalData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PunchesLocalData(
      punchId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}punch_id'],
      )!,
      employeeId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}employee_id'],
      )!,
      jobId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}job_id'],
      )!,
      serviceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}service_id'],
      ),
      punchType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}punch_type'],
      )!,
      timestampDevice: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}timestamp_device'],
      )!,
      gpsLat: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}gps_lat'],
      ),
      gpsLng: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}gps_lng'],
      ),
      gpsAccuracy: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}gps_accuracy'],
      ),
      gpsUnavailable: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}gps_unavailable'],
      )!,
      synced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}synced'],
      )!,
      syncAttempts: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sync_attempts'],
      )!,
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      )!,
      deviceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_id'],
      ),
      lastError: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_error'],
      ),
      requiresDispute: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}requires_dispute'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
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
  const PunchesLocalData({
    required this.punchId,
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
    required this.updatedAt,
  });
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
      gpsLat: gpsLat == null && nullToAbsent
          ? const Value.absent()
          : Value(gpsLat),
      gpsLng: gpsLng == null && nullToAbsent
          ? const Value.absent()
          : Value(gpsLng),
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

  factory PunchesLocalData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
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

  PunchesLocalData copyWith({
    String? punchId,
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
    DateTime? updatedAt,
  }) => PunchesLocalData(
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
      employeeId: data.employeeId.present
          ? data.employeeId.value
          : this.employeeId,
      jobId: data.jobId.present ? data.jobId.value : this.jobId,
      serviceId: data.serviceId.present ? data.serviceId.value : this.serviceId,
      punchType: data.punchType.present ? data.punchType.value : this.punchType,
      timestampDevice: data.timestampDevice.present
          ? data.timestampDevice.value
          : this.timestampDevice,
      gpsLat: data.gpsLat.present ? data.gpsLat.value : this.gpsLat,
      gpsLng: data.gpsLng.present ? data.gpsLng.value : this.gpsLng,
      gpsAccuracy: data.gpsAccuracy.present
          ? data.gpsAccuracy.value
          : this.gpsAccuracy,
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
    updatedAt,
  );
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
  }) : punchId = Value(punchId),
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

  PunchesLocalCompanion copyWith({
    Value<String>? punchId,
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
    Value<int>? rowid,
  }) {
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
    'job_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _serviceIdMeta = const VerificationMeta(
    'serviceId',
  );
  @override
  late final GeneratedColumn<String> serviceId = GeneratedColumn<String>(
    'service_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _customerNameMeta = const VerificationMeta(
    'customerName',
  );
  @override
  late final GeneratedColumn<String> customerName = GeneratedColumn<String>(
    'customer_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _scheduledDateMeta = const VerificationMeta(
    'scheduledDate',
  );
  @override
  late final GeneratedColumn<DateTime> scheduledDate =
      GeneratedColumn<DateTime>(
        'scheduled_date',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _foremanIdMeta = const VerificationMeta(
    'foremanId',
  );
  @override
  late final GeneratedColumn<String> foremanId = GeneratedColumn<String>(
    'foreman_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _crewListJsonMeta = const VerificationMeta(
    'crewListJson',
  );
  @override
  late final GeneratedColumn<String> crewListJson = GeneratedColumn<String>(
    'crew_list_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  static const VerificationMeta _crewHashMeta = const VerificationMeta(
    'crewHash',
  );
  @override
  late final GeneratedColumn<String> crewHash = GeneratedColumn<String>(
    'crew_hash',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastUpdatedMeta = const VerificationMeta(
    'lastUpdated',
  );
  @override
  late final GeneratedColumn<DateTime> lastUpdated = GeneratedColumn<DateTime>(
    'last_updated',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _syncedMeta = const VerificationMeta('synced');
  @override
  late final GeneratedColumn<bool> synced = GeneratedColumn<bool>(
    'synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("synced" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
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
    synced,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'jobs_local';
  @override
  VerificationContext validateIntegrity(
    Insertable<JobsLocalData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('job_id')) {
      context.handle(
        _jobIdMeta,
        jobId.isAcceptableOrUnknown(data['job_id']!, _jobIdMeta),
      );
    } else if (isInserting) {
      context.missing(_jobIdMeta);
    }
    if (data.containsKey('service_id')) {
      context.handle(
        _serviceIdMeta,
        serviceId.isAcceptableOrUnknown(data['service_id']!, _serviceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_serviceIdMeta);
    }
    if (data.containsKey('customer_name')) {
      context.handle(
        _customerNameMeta,
        customerName.isAcceptableOrUnknown(
          data['customer_name']!,
          _customerNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_customerNameMeta);
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    }
    if (data.containsKey('scheduled_date')) {
      context.handle(
        _scheduledDateMeta,
        scheduledDate.isAcceptableOrUnknown(
          data['scheduled_date']!,
          _scheduledDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_scheduledDateMeta);
    }
    if (data.containsKey('foreman_id')) {
      context.handle(
        _foremanIdMeta,
        foremanId.isAcceptableOrUnknown(data['foreman_id']!, _foremanIdMeta),
      );
    }
    if (data.containsKey('crew_list_json')) {
      context.handle(
        _crewListJsonMeta,
        crewListJson.isAcceptableOrUnknown(
          data['crew_list_json']!,
          _crewListJsonMeta,
        ),
      );
    }
    if (data.containsKey('crew_hash')) {
      context.handle(
        _crewHashMeta,
        crewHash.isAcceptableOrUnknown(data['crew_hash']!, _crewHashMeta),
      );
    }
    if (data.containsKey('last_updated')) {
      context.handle(
        _lastUpdatedMeta,
        lastUpdated.isAcceptableOrUnknown(
          data['last_updated']!,
          _lastUpdatedMeta,
        ),
      );
    }
    if (data.containsKey('synced')) {
      context.handle(
        _syncedMeta,
        synced.isAcceptableOrUnknown(data['synced']!, _syncedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {jobId};
  @override
  JobsLocalData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return JobsLocalData(
      jobId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}job_id'],
      )!,
      serviceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}service_id'],
      )!,
      customerName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}customer_name'],
      )!,
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      ),
      scheduledDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}scheduled_date'],
      )!,
      foremanId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}foreman_id'],
      ),
      crewListJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}crew_list_json'],
      )!,
      crewHash: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}crew_hash'],
      ),
      lastUpdated: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_updated'],
      )!,
      synced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}synced'],
      )!,
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
  const JobsLocalData({
    required this.jobId,
    required this.serviceId,
    required this.customerName,
    this.address,
    required this.scheduledDate,
    this.foremanId,
    required this.crewListJson,
    this.crewHash,
    required this.lastUpdated,
    required this.synced,
  });
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

  factory JobsLocalData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
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

  JobsLocalData copyWith({
    String? jobId,
    String? serviceId,
    String? customerName,
    Value<String?> address = const Value.absent(),
    DateTime? scheduledDate,
    Value<String?> foremanId = const Value.absent(),
    String? crewListJson,
    Value<String?> crewHash = const Value.absent(),
    DateTime? lastUpdated,
    bool? synced,
  }) => JobsLocalData(
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
      lastUpdated: data.lastUpdated.present
          ? data.lastUpdated.value
          : this.lastUpdated,
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
  int get hashCode => Object.hash(
    jobId,
    serviceId,
    customerName,
    address,
    scheduledDate,
    foremanId,
    crewListJson,
    crewHash,
    lastUpdated,
    synced,
  );
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
  }) : jobId = Value(jobId),
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

  JobsLocalCompanion copyWith({
    Value<String>? jobId,
    Value<String>? serviceId,
    Value<String>? customerName,
    Value<String?>? address,
    Value<DateTime>? scheduledDate,
    Value<String?>? foremanId,
    Value<String>? crewListJson,
    Value<String?>? crewHash,
    Value<DateTime>? lastUpdated,
    Value<bool>? synced,
    Value<int>? rowid,
  }) {
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
  static const VerificationMeta _employeeIdMeta = const VerificationMeta(
    'employeeId',
  );
  @override
  late final GeneratedColumn<String> employeeId = GeneratedColumn<String>(
    'employee_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _rangeStartMeta = const VerificationMeta(
    'rangeStart',
  );
  @override
  late final GeneratedColumn<DateTime> rangeStart = GeneratedColumn<DateTime>(
    'range_start',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _rangeEndMeta = const VerificationMeta(
    'rangeEnd',
  );
  @override
  late final GeneratedColumn<DateTime> rangeEnd = GeneratedColumn<DateTime>(
    'range_end',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastRefreshedMeta = const VerificationMeta(
    'lastRefreshed',
  );
  @override
  late final GeneratedColumn<DateTime> lastRefreshed =
      GeneratedColumn<DateTime>(
        'last_refreshed',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
        defaultValue: currentDateAndTime,
      );
  static const VerificationMeta _apiVersionMeta = const VerificationMeta(
    'apiVersion',
  );
  @override
  late final GeneratedColumn<String> apiVersion = GeneratedColumn<String>(
    'api_version',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nextCursorMeta = const VerificationMeta(
    'nextCursor',
  );
  @override
  late final GeneratedColumn<String> nextCursor = GeneratedColumn<String>(
    'next_cursor',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    employeeId,
    rangeStart,
    rangeEnd,
    lastRefreshed,
    apiVersion,
    nextCursor,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'job_feed_state_local';
  @override
  VerificationContext validateIntegrity(
    Insertable<JobFeedStateLocalData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('employee_id')) {
      context.handle(
        _employeeIdMeta,
        employeeId.isAcceptableOrUnknown(data['employee_id']!, _employeeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_employeeIdMeta);
    }
    if (data.containsKey('range_start')) {
      context.handle(
        _rangeStartMeta,
        rangeStart.isAcceptableOrUnknown(data['range_start']!, _rangeStartMeta),
      );
    }
    if (data.containsKey('range_end')) {
      context.handle(
        _rangeEndMeta,
        rangeEnd.isAcceptableOrUnknown(data['range_end']!, _rangeEndMeta),
      );
    }
    if (data.containsKey('last_refreshed')) {
      context.handle(
        _lastRefreshedMeta,
        lastRefreshed.isAcceptableOrUnknown(
          data['last_refreshed']!,
          _lastRefreshedMeta,
        ),
      );
    }
    if (data.containsKey('api_version')) {
      context.handle(
        _apiVersionMeta,
        apiVersion.isAcceptableOrUnknown(data['api_version']!, _apiVersionMeta),
      );
    }
    if (data.containsKey('next_cursor')) {
      context.handle(
        _nextCursorMeta,
        nextCursor.isAcceptableOrUnknown(data['next_cursor']!, _nextCursorMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {employeeId};
  @override
  JobFeedStateLocalData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return JobFeedStateLocalData(
      employeeId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}employee_id'],
      )!,
      rangeStart: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}range_start'],
      ),
      rangeEnd: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}range_end'],
      ),
      lastRefreshed: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_refreshed'],
      )!,
      apiVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}api_version'],
      ),
      nextCursor: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}next_cursor'],
      ),
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
  const JobFeedStateLocalData({
    required this.employeeId,
    this.rangeStart,
    this.rangeEnd,
    required this.lastRefreshed,
    this.apiVersion,
    this.nextCursor,
  });
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

  factory JobFeedStateLocalData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
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

  JobFeedStateLocalData copyWith({
    String? employeeId,
    Value<DateTime?> rangeStart = const Value.absent(),
    Value<DateTime?> rangeEnd = const Value.absent(),
    DateTime? lastRefreshed,
    Value<String?> apiVersion = const Value.absent(),
    Value<String?> nextCursor = const Value.absent(),
  }) => JobFeedStateLocalData(
    employeeId: employeeId ?? this.employeeId,
    rangeStart: rangeStart.present ? rangeStart.value : this.rangeStart,
    rangeEnd: rangeEnd.present ? rangeEnd.value : this.rangeEnd,
    lastRefreshed: lastRefreshed ?? this.lastRefreshed,
    apiVersion: apiVersion.present ? apiVersion.value : this.apiVersion,
    nextCursor: nextCursor.present ? nextCursor.value : this.nextCursor,
  );
  JobFeedStateLocalData copyWithCompanion(JobFeedStateLocalCompanion data) {
    return JobFeedStateLocalData(
      employeeId: data.employeeId.present
          ? data.employeeId.value
          : this.employeeId,
      rangeStart: data.rangeStart.present
          ? data.rangeStart.value
          : this.rangeStart,
      rangeEnd: data.rangeEnd.present ? data.rangeEnd.value : this.rangeEnd,
      lastRefreshed: data.lastRefreshed.present
          ? data.lastRefreshed.value
          : this.lastRefreshed,
      apiVersion: data.apiVersion.present
          ? data.apiVersion.value
          : this.apiVersion,
      nextCursor: data.nextCursor.present
          ? data.nextCursor.value
          : this.nextCursor,
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
    employeeId,
    rangeStart,
    rangeEnd,
    lastRefreshed,
    apiVersion,
    nextCursor,
  );
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

  JobFeedStateLocalCompanion copyWith({
    Value<String>? employeeId,
    Value<DateTime?>? rangeStart,
    Value<DateTime?>? rangeEnd,
    Value<DateTime>? lastRefreshed,
    Value<String?>? apiVersion,
    Value<String?>? nextCursor,
    Value<int>? rowid,
  }) {
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
  static const VerificationMeta _employeeIdMeta = const VerificationMeta(
    'employeeId',
  );
  @override
  late final GeneratedColumn<String> employeeId = GeneratedColumn<String>(
    'employee_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _displayNameMeta = const VerificationMeta(
    'displayName',
  );
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
    'display_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _crewMeta = const VerificationMeta('crew');
  @override
  late final GeneratedColumn<String> crew = GeneratedColumn<String>(
    'crew',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
    'role',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deviceIdMeta = const VerificationMeta(
    'deviceId',
  );
  @override
  late final GeneratedColumn<String> deviceId = GeneratedColumn<String>(
    'device_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _osVersionMeta = const VerificationMeta(
    'osVersion',
  );
  @override
  late final GeneratedColumn<String> osVersion = GeneratedColumn<String>(
    'os_version',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastSyncMeta = const VerificationMeta(
    'lastSync',
  );
  @override
  late final GeneratedColumn<DateTime> lastSync = GeneratedColumn<DateTime>(
    'last_sync',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
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
    lastSync,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'profile_local';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProfileLocalData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('employee_id')) {
      context.handle(
        _employeeIdMeta,
        employeeId.isAcceptableOrUnknown(data['employee_id']!, _employeeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_employeeIdMeta);
    }
    if (data.containsKey('display_name')) {
      context.handle(
        _displayNameMeta,
        displayName.isAcceptableOrUnknown(
          data['display_name']!,
          _displayNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_displayNameMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('crew')) {
      context.handle(
        _crewMeta,
        crew.isAcceptableOrUnknown(data['crew']!, _crewMeta),
      );
    }
    if (data.containsKey('role')) {
      context.handle(
        _roleMeta,
        role.isAcceptableOrUnknown(data['role']!, _roleMeta),
      );
    }
    if (data.containsKey('device_id')) {
      context.handle(
        _deviceIdMeta,
        deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta),
      );
    }
    if (data.containsKey('os_version')) {
      context.handle(
        _osVersionMeta,
        osVersion.isAcceptableOrUnknown(data['os_version']!, _osVersionMeta),
      );
    }
    if (data.containsKey('last_sync')) {
      context.handle(
        _lastSyncMeta,
        lastSync.isAcceptableOrUnknown(data['last_sync']!, _lastSyncMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {employeeId};
  @override
  ProfileLocalData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProfileLocalData(
      employeeId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}employee_id'],
      )!,
      displayName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_name'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      crew: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}crew'],
      ),
      role: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}role'],
      ),
      deviceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_id'],
      ),
      osVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}os_version'],
      ),
      lastSync: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_sync'],
      ),
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
  const ProfileLocalData({
    required this.employeeId,
    required this.displayName,
    this.email,
    this.phone,
    this.crew,
    this.role,
    this.deviceId,
    this.osVersion,
    this.lastSync,
  });
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
      email: email == null && nullToAbsent
          ? const Value.absent()
          : Value(email),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
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

  factory ProfileLocalData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
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

  ProfileLocalData copyWith({
    String? employeeId,
    String? displayName,
    Value<String?> email = const Value.absent(),
    Value<String?> phone = const Value.absent(),
    Value<String?> crew = const Value.absent(),
    Value<String?> role = const Value.absent(),
    Value<String?> deviceId = const Value.absent(),
    Value<String?> osVersion = const Value.absent(),
    Value<DateTime?> lastSync = const Value.absent(),
  }) => ProfileLocalData(
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
      employeeId: data.employeeId.present
          ? data.employeeId.value
          : this.employeeId,
      displayName: data.displayName.present
          ? data.displayName.value
          : this.displayName,
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
  int get hashCode => Object.hash(
    employeeId,
    displayName,
    email,
    phone,
    crew,
    role,
    deviceId,
    osVersion,
    lastSync,
  );
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
  }) : employeeId = Value(employeeId),
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

  ProfileLocalCompanion copyWith({
    Value<String>? employeeId,
    Value<String>? displayName,
    Value<String?>? email,
    Value<String?>? phone,
    Value<String?>? crew,
    Value<String?>? role,
    Value<String?>? deviceId,
    Value<String?>? osVersion,
    Value<DateTime?>? lastSync,
    Value<int>? rowid,
  }) {
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
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _entityTypeMeta = const VerificationMeta(
    'entityType',
  );
  @override
  late final GeneratedColumn<String> entityType = GeneratedColumn<String>(
    'entity_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payloadMeta = const VerificationMeta(
    'payload',
  );
  @override
  late final GeneratedColumn<String> payload = GeneratedColumn<String>(
    'payload',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _attemptCountMeta = const VerificationMeta(
    'attemptCount',
  );
  @override
  late final GeneratedColumn<int> attemptCount = GeneratedColumn<int>(
    'attempt_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastErrorMeta = const VerificationMeta(
    'lastError',
  );
  @override
  late final GeneratedColumn<String> lastError = GeneratedColumn<String>(
    'last_error',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _lastAttemptAtMeta = const VerificationMeta(
    'lastAttemptAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastAttemptAt =
      GeneratedColumn<DateTime>(
        'last_attempt_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _mobileUuidMeta = const VerificationMeta(
    'mobileUuid',
  );
  @override
  late final GeneratedColumn<String> mobileUuid = GeneratedColumn<String>(
    'mobile_uuid',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    entityType,
    payload,
    attemptCount,
    lastError,
    createdAt,
    lastAttemptAt,
    mobileUuid,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_queue';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncQueueData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('entity_type')) {
      context.handle(
        _entityTypeMeta,
        entityType.isAcceptableOrUnknown(data['entity_type']!, _entityTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_entityTypeMeta);
    }
    if (data.containsKey('payload')) {
      context.handle(
        _payloadMeta,
        payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta),
      );
    } else if (isInserting) {
      context.missing(_payloadMeta);
    }
    if (data.containsKey('attempt_count')) {
      context.handle(
        _attemptCountMeta,
        attemptCount.isAcceptableOrUnknown(
          data['attempt_count']!,
          _attemptCountMeta,
        ),
      );
    }
    if (data.containsKey('last_error')) {
      context.handle(
        _lastErrorMeta,
        lastError.isAcceptableOrUnknown(data['last_error']!, _lastErrorMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('last_attempt_at')) {
      context.handle(
        _lastAttemptAtMeta,
        lastAttemptAt.isAcceptableOrUnknown(
          data['last_attempt_at']!,
          _lastAttemptAtMeta,
        ),
      );
    }
    if (data.containsKey('mobile_uuid')) {
      context.handle(
        _mobileUuidMeta,
        mobileUuid.isAcceptableOrUnknown(data['mobile_uuid']!, _mobileUuidMeta),
      );
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
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      entityType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_type'],
      )!,
      payload: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload'],
      )!,
      attemptCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}attempt_count'],
      )!,
      lastError: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_error'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      lastAttemptAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_attempt_at'],
      ),
      mobileUuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mobile_uuid'],
      ),
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
  const SyncQueueData({
    required this.id,
    required this.entityType,
    required this.payload,
    required this.attemptCount,
    this.lastError,
    required this.createdAt,
    this.lastAttemptAt,
    this.mobileUuid,
  });
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

  factory SyncQueueData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
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

  SyncQueueData copyWith({
    int? id,
    String? entityType,
    String? payload,
    int? attemptCount,
    Value<String?> lastError = const Value.absent(),
    DateTime? createdAt,
    Value<DateTime?> lastAttemptAt = const Value.absent(),
    Value<String?> mobileUuid = const Value.absent(),
  }) => SyncQueueData(
    id: id ?? this.id,
    entityType: entityType ?? this.entityType,
    payload: payload ?? this.payload,
    attemptCount: attemptCount ?? this.attemptCount,
    lastError: lastError.present ? lastError.value : this.lastError,
    createdAt: createdAt ?? this.createdAt,
    lastAttemptAt: lastAttemptAt.present
        ? lastAttemptAt.value
        : this.lastAttemptAt,
    mobileUuid: mobileUuid.present ? mobileUuid.value : this.mobileUuid,
  );
  SyncQueueData copyWithCompanion(SyncQueueCompanion data) {
    return SyncQueueData(
      id: data.id.present ? data.id.value : this.id,
      entityType: data.entityType.present
          ? data.entityType.value
          : this.entityType,
      payload: data.payload.present ? data.payload.value : this.payload,
      attemptCount: data.attemptCount.present
          ? data.attemptCount.value
          : this.attemptCount,
      lastError: data.lastError.present ? data.lastError.value : this.lastError,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      lastAttemptAt: data.lastAttemptAt.present
          ? data.lastAttemptAt.value
          : this.lastAttemptAt,
      mobileUuid: data.mobileUuid.present
          ? data.mobileUuid.value
          : this.mobileUuid,
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
  int get hashCode => Object.hash(
    id,
    entityType,
    payload,
    attemptCount,
    lastError,
    createdAt,
    lastAttemptAt,
    mobileUuid,
  );
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
  }) : entityType = Value(entityType),
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

  SyncQueueCompanion copyWith({
    Value<int>? id,
    Value<String>? entityType,
    Value<String>? payload,
    Value<int>? attemptCount,
    Value<String?>? lastError,
    Value<DateTime>? createdAt,
    Value<DateTime?>? lastAttemptAt,
    Value<String?>? mobileUuid,
  }) {
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
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _originalQueueIdMeta = const VerificationMeta(
    'originalQueueId',
  );
  @override
  late final GeneratedColumn<int> originalQueueId = GeneratedColumn<int>(
    'original_queue_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _entityTypeMeta = const VerificationMeta(
    'entityType',
  );
  @override
  late final GeneratedColumn<String> entityType = GeneratedColumn<String>(
    'entity_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _payloadMeta = const VerificationMeta(
    'payload',
  );
  @override
  late final GeneratedColumn<String> payload = GeneratedColumn<String>(
    'payload',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _errorMeta = const VerificationMeta('error');
  @override
  late final GeneratedColumn<String> error = GeneratedColumn<String>(
    'error',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    originalQueueId,
    entityType,
    payload,
    error,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'corrupt_queue_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<CorruptQueueEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('original_queue_id')) {
      context.handle(
        _originalQueueIdMeta,
        originalQueueId.isAcceptableOrUnknown(
          data['original_queue_id']!,
          _originalQueueIdMeta,
        ),
      );
    }
    if (data.containsKey('entity_type')) {
      context.handle(
        _entityTypeMeta,
        entityType.isAcceptableOrUnknown(data['entity_type']!, _entityTypeMeta),
      );
    }
    if (data.containsKey('payload')) {
      context.handle(
        _payloadMeta,
        payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta),
      );
    }
    if (data.containsKey('error')) {
      context.handle(
        _errorMeta,
        error.isAcceptableOrUnknown(data['error']!, _errorMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CorruptQueueEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CorruptQueueEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      originalQueueId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}original_queue_id'],
      ),
      entityType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_type'],
      ),
      payload: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload'],
      ),
      error: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}error'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
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
  const CorruptQueueEntry({
    required this.id,
    this.originalQueueId,
    this.entityType,
    this.payload,
    this.error,
    required this.createdAt,
  });
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
      error: error == null && nullToAbsent
          ? const Value.absent()
          : Value(error),
      createdAt: Value(createdAt),
    );
  }

  factory CorruptQueueEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
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

  CorruptQueueEntry copyWith({
    int? id,
    Value<int?> originalQueueId = const Value.absent(),
    Value<String?> entityType = const Value.absent(),
    Value<String?> payload = const Value.absent(),
    Value<String?> error = const Value.absent(),
    DateTime? createdAt,
  }) => CorruptQueueEntry(
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
      entityType: data.entityType.present
          ? data.entityType.value
          : this.entityType,
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

  CorruptQueueEntriesCompanion copyWith({
    Value<int>? id,
    Value<int?>? originalQueueId,
    Value<String?>? entityType,
    Value<String?>? payload,
    Value<String?>? error,
    Value<DateTime>? createdAt,
  }) {
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
  ];
}

typedef $$PunchesLocalTableCreateCompanionBuilder =
    PunchesLocalCompanion Function({
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
typedef $$PunchesLocalTableUpdateCompanionBuilder =
    PunchesLocalCompanion Function({
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
    column: $table.punchId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get employeeId => $composableBuilder(
    column: $table.employeeId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get jobId => $composableBuilder(
    column: $table.jobId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get serviceId => $composableBuilder(
    column: $table.serviceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get punchType => $composableBuilder(
    column: $table.punchType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get timestampDevice => $composableBuilder(
    column: $table.timestampDevice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get gpsLat => $composableBuilder(
    column: $table.gpsLat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get gpsLng => $composableBuilder(
    column: $table.gpsLng,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get gpsAccuracy => $composableBuilder(
    column: $table.gpsAccuracy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get gpsUnavailable => $composableBuilder(
    column: $table.gpsUnavailable,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get synced => $composableBuilder(
    column: $table.synced,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get syncAttempts => $composableBuilder(
    column: $table.syncAttempts,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastError => $composableBuilder(
    column: $table.lastError,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get requiresDispute => $composableBuilder(
    column: $table.requiresDispute,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
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
    column: $table.punchId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get employeeId => $composableBuilder(
    column: $table.employeeId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get jobId => $composableBuilder(
    column: $table.jobId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get serviceId => $composableBuilder(
    column: $table.serviceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get punchType => $composableBuilder(
    column: $table.punchType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get timestampDevice => $composableBuilder(
    column: $table.timestampDevice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get gpsLat => $composableBuilder(
    column: $table.gpsLat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get gpsLng => $composableBuilder(
    column: $table.gpsLng,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get gpsAccuracy => $composableBuilder(
    column: $table.gpsAccuracy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get gpsUnavailable => $composableBuilder(
    column: $table.gpsUnavailable,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get synced => $composableBuilder(
    column: $table.synced,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get syncAttempts => $composableBuilder(
    column: $table.syncAttempts,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastError => $composableBuilder(
    column: $table.lastError,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get requiresDispute => $composableBuilder(
    column: $table.requiresDispute,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
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
    column: $table.employeeId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get jobId =>
      $composableBuilder(column: $table.jobId, builder: (column) => column);

  GeneratedColumn<String> get serviceId =>
      $composableBuilder(column: $table.serviceId, builder: (column) => column);

  GeneratedColumn<String> get punchType =>
      $composableBuilder(column: $table.punchType, builder: (column) => column);

  GeneratedColumn<DateTime> get timestampDevice => $composableBuilder(
    column: $table.timestampDevice,
    builder: (column) => column,
  );

  GeneratedColumn<double> get gpsLat =>
      $composableBuilder(column: $table.gpsLat, builder: (column) => column);

  GeneratedColumn<double> get gpsLng =>
      $composableBuilder(column: $table.gpsLng, builder: (column) => column);

  GeneratedColumn<double> get gpsAccuracy => $composableBuilder(
    column: $table.gpsAccuracy,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get gpsUnavailable => $composableBuilder(
    column: $table.gpsUnavailable,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get synced =>
      $composableBuilder(column: $table.synced, builder: (column) => column);

  GeneratedColumn<int> get syncAttempts => $composableBuilder(
    column: $table.syncAttempts,
    builder: (column) => column,
  );

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<String> get deviceId =>
      $composableBuilder(column: $table.deviceId, builder: (column) => column);

  GeneratedColumn<String> get lastError =>
      $composableBuilder(column: $table.lastError, builder: (column) => column);

  GeneratedColumn<bool> get requiresDispute => $composableBuilder(
    column: $table.requiresDispute,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$PunchesLocalTableTableManager
    extends
        RootTableManager<
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
            BaseReferences<_$AppDatabase, $PunchesLocalTable, PunchesLocalData>,
          ),
          PunchesLocalData,
          PrefetchHooks Function()
        > {
  $$PunchesLocalTableTableManager(_$AppDatabase db, $PunchesLocalTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PunchesLocalTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PunchesLocalTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PunchesLocalTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
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
              }) => PunchesLocalCompanion(
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
          createCompanionCallback:
              ({
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
              }) => PunchesLocalCompanion.insert(
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
        ),
      );
}

typedef $$PunchesLocalTableProcessedTableManager =
    ProcessedTableManager<
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
        BaseReferences<_$AppDatabase, $PunchesLocalTable, PunchesLocalData>,
      ),
      PunchesLocalData,
      PrefetchHooks Function()
    >;
typedef $$JobsLocalTableCreateCompanionBuilder =
    JobsLocalCompanion Function({
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
typedef $$JobsLocalTableUpdateCompanionBuilder =
    JobsLocalCompanion Function({
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
    column: $table.jobId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get serviceId => $composableBuilder(
    column: $table.serviceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get customerName => $composableBuilder(
    column: $table.customerName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get scheduledDate => $composableBuilder(
    column: $table.scheduledDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get foremanId => $composableBuilder(
    column: $table.foremanId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get crewListJson => $composableBuilder(
    column: $table.crewListJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get crewHash => $composableBuilder(
    column: $table.crewHash,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastUpdated => $composableBuilder(
    column: $table.lastUpdated,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get synced => $composableBuilder(
    column: $table.synced,
    builder: (column) => ColumnFilters(column),
  );
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
    column: $table.jobId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get serviceId => $composableBuilder(
    column: $table.serviceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customerName => $composableBuilder(
    column: $table.customerName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get scheduledDate => $composableBuilder(
    column: $table.scheduledDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get foremanId => $composableBuilder(
    column: $table.foremanId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get crewListJson => $composableBuilder(
    column: $table.crewListJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get crewHash => $composableBuilder(
    column: $table.crewHash,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastUpdated => $composableBuilder(
    column: $table.lastUpdated,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get synced => $composableBuilder(
    column: $table.synced,
    builder: (column) => ColumnOrderings(column),
  );
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
    column: $table.customerName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<DateTime> get scheduledDate => $composableBuilder(
    column: $table.scheduledDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get foremanId =>
      $composableBuilder(column: $table.foremanId, builder: (column) => column);

  GeneratedColumn<String> get crewListJson => $composableBuilder(
    column: $table.crewListJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get crewHash =>
      $composableBuilder(column: $table.crewHash, builder: (column) => column);

  GeneratedColumn<DateTime> get lastUpdated => $composableBuilder(
    column: $table.lastUpdated,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get synced =>
      $composableBuilder(column: $table.synced, builder: (column) => column);
}

class $$JobsLocalTableTableManager
    extends
        RootTableManager<
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
            BaseReferences<_$AppDatabase, $JobsLocalTable, JobsLocalData>,
          ),
          JobsLocalData,
          PrefetchHooks Function()
        > {
  $$JobsLocalTableTableManager(_$AppDatabase db, $JobsLocalTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$JobsLocalTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$JobsLocalTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$JobsLocalTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
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
              }) => JobsLocalCompanion(
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
          createCompanionCallback:
              ({
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
              }) => JobsLocalCompanion.insert(
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
        ),
      );
}

typedef $$JobsLocalTableProcessedTableManager =
    ProcessedTableManager<
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
        BaseReferences<_$AppDatabase, $JobsLocalTable, JobsLocalData>,
      ),
      JobsLocalData,
      PrefetchHooks Function()
    >;
typedef $$JobFeedStateLocalTableCreateCompanionBuilder =
    JobFeedStateLocalCompanion Function({
      required String employeeId,
      Value<DateTime?> rangeStart,
      Value<DateTime?> rangeEnd,
      Value<DateTime> lastRefreshed,
      Value<String?> apiVersion,
      Value<String?> nextCursor,
      Value<int> rowid,
    });
typedef $$JobFeedStateLocalTableUpdateCompanionBuilder =
    JobFeedStateLocalCompanion Function({
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
    column: $table.employeeId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get rangeStart => $composableBuilder(
    column: $table.rangeStart,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get rangeEnd => $composableBuilder(
    column: $table.rangeEnd,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastRefreshed => $composableBuilder(
    column: $table.lastRefreshed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get apiVersion => $composableBuilder(
    column: $table.apiVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nextCursor => $composableBuilder(
    column: $table.nextCursor,
    builder: (column) => ColumnFilters(column),
  );
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
    column: $table.employeeId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get rangeStart => $composableBuilder(
    column: $table.rangeStart,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get rangeEnd => $composableBuilder(
    column: $table.rangeEnd,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastRefreshed => $composableBuilder(
    column: $table.lastRefreshed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get apiVersion => $composableBuilder(
    column: $table.apiVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nextCursor => $composableBuilder(
    column: $table.nextCursor,
    builder: (column) => ColumnOrderings(column),
  );
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
    column: $table.employeeId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get rangeStart => $composableBuilder(
    column: $table.rangeStart,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get rangeEnd =>
      $composableBuilder(column: $table.rangeEnd, builder: (column) => column);

  GeneratedColumn<DateTime> get lastRefreshed => $composableBuilder(
    column: $table.lastRefreshed,
    builder: (column) => column,
  );

  GeneratedColumn<String> get apiVersion => $composableBuilder(
    column: $table.apiVersion,
    builder: (column) => column,
  );

  GeneratedColumn<String> get nextCursor => $composableBuilder(
    column: $table.nextCursor,
    builder: (column) => column,
  );
}

class $$JobFeedStateLocalTableTableManager
    extends
        RootTableManager<
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
            BaseReferences<
              _$AppDatabase,
              $JobFeedStateLocalTable,
              JobFeedStateLocalData
            >,
          ),
          JobFeedStateLocalData,
          PrefetchHooks Function()
        > {
  $$JobFeedStateLocalTableTableManager(
    _$AppDatabase db,
    $JobFeedStateLocalTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$JobFeedStateLocalTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$JobFeedStateLocalTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$JobFeedStateLocalTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> employeeId = const Value.absent(),
                Value<DateTime?> rangeStart = const Value.absent(),
                Value<DateTime?> rangeEnd = const Value.absent(),
                Value<DateTime> lastRefreshed = const Value.absent(),
                Value<String?> apiVersion = const Value.absent(),
                Value<String?> nextCursor = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => JobFeedStateLocalCompanion(
                employeeId: employeeId,
                rangeStart: rangeStart,
                rangeEnd: rangeEnd,
                lastRefreshed: lastRefreshed,
                apiVersion: apiVersion,
                nextCursor: nextCursor,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String employeeId,
                Value<DateTime?> rangeStart = const Value.absent(),
                Value<DateTime?> rangeEnd = const Value.absent(),
                Value<DateTime> lastRefreshed = const Value.absent(),
                Value<String?> apiVersion = const Value.absent(),
                Value<String?> nextCursor = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => JobFeedStateLocalCompanion.insert(
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
        ),
      );
}

typedef $$JobFeedStateLocalTableProcessedTableManager =
    ProcessedTableManager<
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
        BaseReferences<
          _$AppDatabase,
          $JobFeedStateLocalTable,
          JobFeedStateLocalData
        >,
      ),
      JobFeedStateLocalData,
      PrefetchHooks Function()
    >;
typedef $$ProfileLocalTableCreateCompanionBuilder =
    ProfileLocalCompanion Function({
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
typedef $$ProfileLocalTableUpdateCompanionBuilder =
    ProfileLocalCompanion Function({
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
    column: $table.employeeId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get crew => $composableBuilder(
    column: $table.crew,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get osVersion => $composableBuilder(
    column: $table.osVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastSync => $composableBuilder(
    column: $table.lastSync,
    builder: (column) => ColumnFilters(column),
  );
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
    column: $table.employeeId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get crew => $composableBuilder(
    column: $table.crew,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get osVersion => $composableBuilder(
    column: $table.osVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastSync => $composableBuilder(
    column: $table.lastSync,
    builder: (column) => ColumnOrderings(column),
  );
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
    column: $table.employeeId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => column,
  );

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

class $$ProfileLocalTableTableManager
    extends
        RootTableManager<
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
            BaseReferences<_$AppDatabase, $ProfileLocalTable, ProfileLocalData>,
          ),
          ProfileLocalData,
          PrefetchHooks Function()
        > {
  $$ProfileLocalTableTableManager(_$AppDatabase db, $ProfileLocalTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProfileLocalTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProfileLocalTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProfileLocalTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
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
              }) => ProfileLocalCompanion(
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
          createCompanionCallback:
              ({
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
              }) => ProfileLocalCompanion.insert(
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
        ),
      );
}

typedef $$ProfileLocalTableProcessedTableManager =
    ProcessedTableManager<
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
        BaseReferences<_$AppDatabase, $ProfileLocalTable, ProfileLocalData>,
      ),
      ProfileLocalData,
      PrefetchHooks Function()
    >;
typedef $$SyncQueueTableCreateCompanionBuilder =
    SyncQueueCompanion Function({
      Value<int> id,
      required String entityType,
      required String payload,
      Value<int> attemptCount,
      Value<String?> lastError,
      Value<DateTime> createdAt,
      Value<DateTime?> lastAttemptAt,
      Value<String?> mobileUuid,
    });
typedef $$SyncQueueTableUpdateCompanionBuilder =
    SyncQueueCompanion Function({
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
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get attemptCount => $composableBuilder(
    column: $table.attemptCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastError => $composableBuilder(
    column: $table.lastError,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastAttemptAt => $composableBuilder(
    column: $table.lastAttemptAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mobileUuid => $composableBuilder(
    column: $table.mobileUuid,
    builder: (column) => ColumnFilters(column),
  );
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
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get attemptCount => $composableBuilder(
    column: $table.attemptCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastError => $composableBuilder(
    column: $table.lastError,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastAttemptAt => $composableBuilder(
    column: $table.lastAttemptAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mobileUuid => $composableBuilder(
    column: $table.mobileUuid,
    builder: (column) => ColumnOrderings(column),
  );
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
    column: $table.entityType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get payload =>
      $composableBuilder(column: $table.payload, builder: (column) => column);

  GeneratedColumn<int> get attemptCount => $composableBuilder(
    column: $table.attemptCount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastError =>
      $composableBuilder(column: $table.lastError, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get lastAttemptAt => $composableBuilder(
    column: $table.lastAttemptAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get mobileUuid => $composableBuilder(
    column: $table.mobileUuid,
    builder: (column) => column,
  );
}

class $$SyncQueueTableTableManager
    extends
        RootTableManager<
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
            BaseReferences<_$AppDatabase, $SyncQueueTable, SyncQueueData>,
          ),
          SyncQueueData,
          PrefetchHooks Function()
        > {
  $$SyncQueueTableTableManager(_$AppDatabase db, $SyncQueueTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncQueueTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncQueueTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncQueueTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> entityType = const Value.absent(),
                Value<String> payload = const Value.absent(),
                Value<int> attemptCount = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> lastAttemptAt = const Value.absent(),
                Value<String?> mobileUuid = const Value.absent(),
              }) => SyncQueueCompanion(
                id: id,
                entityType: entityType,
                payload: payload,
                attemptCount: attemptCount,
                lastError: lastError,
                createdAt: createdAt,
                lastAttemptAt: lastAttemptAt,
                mobileUuid: mobileUuid,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String entityType,
                required String payload,
                Value<int> attemptCount = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> lastAttemptAt = const Value.absent(),
                Value<String?> mobileUuid = const Value.absent(),
              }) => SyncQueueCompanion.insert(
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
        ),
      );
}

typedef $$SyncQueueTableProcessedTableManager =
    ProcessedTableManager<
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
        BaseReferences<_$AppDatabase, $SyncQueueTable, SyncQueueData>,
      ),
      SyncQueueData,
      PrefetchHooks Function()
    >;
typedef $$CorruptQueueEntriesTableCreateCompanionBuilder =
    CorruptQueueEntriesCompanion Function({
      Value<int> id,
      Value<int?> originalQueueId,
      Value<String?> entityType,
      Value<String?> payload,
      Value<String?> error,
      Value<DateTime> createdAt,
    });
typedef $$CorruptQueueEntriesTableUpdateCompanionBuilder =
    CorruptQueueEntriesCompanion Function({
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
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get originalQueueId => $composableBuilder(
    column: $table.originalQueueId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get error => $composableBuilder(
    column: $table.error,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
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
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get originalQueueId => $composableBuilder(
    column: $table.originalQueueId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get error => $composableBuilder(
    column: $table.error,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
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
    column: $table.originalQueueId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get payload =>
      $composableBuilder(column: $table.payload, builder: (column) => column);

  GeneratedColumn<String> get error =>
      $composableBuilder(column: $table.error, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$CorruptQueueEntriesTableTableManager
    extends
        RootTableManager<
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
            BaseReferences<
              _$AppDatabase,
              $CorruptQueueEntriesTable,
              CorruptQueueEntry
            >,
          ),
          CorruptQueueEntry,
          PrefetchHooks Function()
        > {
  $$CorruptQueueEntriesTableTableManager(
    _$AppDatabase db,
    $CorruptQueueEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CorruptQueueEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CorruptQueueEntriesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$CorruptQueueEntriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> originalQueueId = const Value.absent(),
                Value<String?> entityType = const Value.absent(),
                Value<String?> payload = const Value.absent(),
                Value<String?> error = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => CorruptQueueEntriesCompanion(
                id: id,
                originalQueueId: originalQueueId,
                entityType: entityType,
                payload: payload,
                error: error,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> originalQueueId = const Value.absent(),
                Value<String?> entityType = const Value.absent(),
                Value<String?> payload = const Value.absent(),
                Value<String?> error = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => CorruptQueueEntriesCompanion.insert(
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
        ),
      );
}

typedef $$CorruptQueueEntriesTableProcessedTableManager =
    ProcessedTableManager<
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
        BaseReferences<
          _$AppDatabase,
          $CorruptQueueEntriesTable,
          CorruptQueueEntry
        >,
      ),
      CorruptQueueEntry,
      PrefetchHooks Function()
    >;

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
}
