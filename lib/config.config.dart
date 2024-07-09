// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'core/api/api_manager.dart' as _i3;
import 'core/Firebase/FirebaseFunctions.dart' as _i4;
import 'core/Location/location.dart' as _i5;
import 'features/Login/data/data_sources/loginDs.dart' as _i8;
import 'features/Login/data/data_sources/LoginDsImp.dart' as _i9;
import 'features/Login/data/repositories/loginRepoImp.dart' as _i20;
import 'features/Login/domain/entities/LoginRepo.dart' as _i19;
import 'features/Login/domain/use_cases/LoginUseCase.dart' as _i23;
import 'features/Login/presentation/bloc/login_bloc.dart' as _i24;
import 'features/News/data/data_sources/RemoteDs/NewsDs.dart' as _i10;
import 'features/News/data/data_sources/RemoteDs/NewsModelImp.dart' as _i11;
import 'features/News/data/repositories/newsRepoImp.dart' as _i15;
import 'features/News/domain/repositories/newsRepo.dart' as _i14;
import 'features/News/domain/use_cases/news_usecase.dart' as _i16;
import 'features/News/presentation/bloc/news_bloc.dart' as _i22;
import 'features/signUp/data/data_sources/remoteDs/SignUpDs.dart' as _i6;
import 'features/signUp/data/data_sources/remoteDs/SignUpDsImp.dart' as _i7;
import 'features/signUp/data/repositories/SignUpRepoImp.dart' as _i13;
import 'features/signUp/domain/repositories/SignUpRepo.dart' as _i12;
import 'features/signUp/domain/use_cases/signUp_useCase.dart' as _i17;
import 'features/signUp/domain/use_cases/storeuserUseCase.dart' as _i18;
import 'features/signUp/presentation/manager/sign_up_bloc.dart' as _i21;

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
    gh.factory<_i3.ApiManager>(() => _i3.ApiManager());
    gh.factory<_i4.FirebaseFunctions>(() => _i4.FirebaseFunctions());
    gh.factory<_i5.GetCurrentLocation>(() => _i5.GetCurrentLocation());
    gh.factory<_i6.SignUpDs>(
        () => _i7.SignUpDsImp(gh<_i4.FirebaseFunctions>()));
    gh.factory<_i8.LoginDs>(() => _i9.LoginDsImp(gh<_i4.FirebaseFunctions>()));
    gh.factory<_i10.NewsDs>(() => _i11.NewsDsImp(gh<_i3.ApiManager>()));
    gh.factory<_i12.SignUpRepo>(() => _i13.SignUpRepoImp(gh<_i6.SignUpDs>()));
    gh.factory<_i14.NewsRepo>(() => _i15.NewsRepoImp(gh<_i10.NewsDs>()));
    gh.factory<_i16.NewsUseCase>(() => _i16.NewsUseCase(gh<_i14.NewsRepo>()));
    gh.factory<_i17.SignUpUseCase>(
        () => _i17.SignUpUseCase(gh<_i12.SignUpRepo>()));
    gh.factory<_i18.StoreUserUseCase>(
        () => _i18.StoreUserUseCase(gh<_i12.SignUpRepo>()));
    gh.factory<_i19.LoginRepo>(() => _i20.LoginRepoImp(gh<_i8.LoginDs>()));
    gh.factory<_i21.SignUpBloc>(() => _i21.SignUpBloc(
          gh<_i5.GetCurrentLocation>(),
          gh<_i17.SignUpUseCase>(),
          gh<_i18.StoreUserUseCase>(),
        ));
    gh.factory<_i22.NewsBloc>(() => _i22.NewsBloc(gh<_i16.NewsUseCase>()));
    gh.factory<_i23.LoginUseCase>(
        () => _i23.LoginUseCase(gh<_i19.LoginRepo>()));
    gh.factory<_i24.LoginBloc>(() => _i24.LoginBloc(gh<_i23.LoginUseCase>()));
    return this;
  }
}
