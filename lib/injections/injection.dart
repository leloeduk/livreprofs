// import 'package:livreprofs/core/network/network._info.dart';
// import 'package:livreprofs/features/documents/data/repositories/document_repository_impl.dart';

// final getIt = GetIt.instance;

// Future<void> init() async {
//   // Blocs
//   getIt.registerFactory(() => DocumentBloc(getDocuments: getIt()));

//   // Use cases
//   getIt.registerLazySingleton(() => GetDocuments(getIt()));

//   // Repository
//   getIt.registerLazySingleton<DocumentRepository>(
//     () => DocumentRepositoryImpl(remoteDataSource: getIt()),
//   );

//   // Data sources
//   getIt.registerLazySingleton<DocumentRemoteDataSource>(
//     () => DocumentRemoteDataSourceImpl(dio: getIt()),
//   );
//   // Data sources
//   getIt.registerLazySingleton<DocumentRemoteDataSource>(
//     () => DocumentRemoteDataSourceImpl(dio: getIt()),
//   );

//   // Repository
//   getIt.registerLazySingleton<DocumentRepository>(
//     () =>
//         DocumentRepositoryImpl(remoteDataSource: getIt(), networkInfo: getIt()),
//   );

//   // Core
//   getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(getIt()));
//   // External
//   getIt.registerSingleton(Dio());
//   getIt.registerSingleton(AdService());
//   getIt.registerSingleton(ConnectivityService());
// }
