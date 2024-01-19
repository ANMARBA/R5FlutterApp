// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i5;
import 'package:firebase_auth/firebase_auth.dart' as _i4;
import 'package:flutter_r5_app/core/shared/dependency_injection/dependency_injection.dart'
    as _i13;
import 'package:flutter_r5_app/core/shared/utils/auth.dart' as _i3;
import 'package:flutter_r5_app/features/home/domain/usecases/add_todo_use_case.dart'
    as _i10;
import 'package:flutter_r5_app/features/home/domain/usecases/delete_todo_use_case.dart'
    as _i11;
import 'package:flutter_r5_app/features/home/domain/usecases/get_todos_use_case.dart'
    as _i12;
import 'package:flutter_r5_app/features/home/domain/usecases/update_state_todo_use_case.dart'
    as _i9;
import 'package:flutter_r5_app/features/home/home.dart' as _i7;
import 'package:flutter_r5_app/features/home/infrastructure/data/datasources/remote_services/task_remote_service.dart'
    as _i6;
import 'package:flutter_r5_app/features/home/infrastructure/data/repositories/task_repository_imp.dart'
    as _i8;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final injectableModule = _$InjectableModule();
    gh.lazySingleton<_i3.AuthService>(() => _i3.AuthService());
    gh.lazySingleton<_i4.FirebaseAuth>(() => injectableModule.firebaseAuth);
    gh.lazySingleton<_i5.FirebaseFirestore>(() => injectableModule.firestore);
    gh.factory<_i6.TaskRemoteService>(() => _i6.TabAwardsRemoteServiceImpl());
    gh.factory<_i7.TaskRepository>(
        () => _i8.TaskRepositoryImp(gh<_i7.TaskRemoteService>()));
    gh.factory<_i9.UpdateStateTODOUseCase>(
        () => _i9.UpdateStateTODOUseCase(gh<_i7.TaskRepository>()));
    gh.factory<_i10.AddTODOUseCase>(
        () => _i10.AddTODOUseCase(gh<_i7.TaskRepository>()));
    gh.factory<_i11.DeleteTODOUseCase>(
        () => _i11.DeleteTODOUseCase(gh<_i7.TaskRepository>()));
    gh.factory<_i12.GetTODOsUseCase>(
        () => _i12.GetTODOsUseCase(gh<_i7.TaskRepository>()));
    return this;
  }
}

class _$InjectableModule extends _i13.InjectableModule {}
