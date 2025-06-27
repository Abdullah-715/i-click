import 'package:get_it/get_it.dart';
import '../features/chat/data/data_source/chat_remote.dart';
import '../features/chat/data/repository/chat_repo_impl.dart';
import '../features/chat/domain/repo/chat_repo.dart';
import '../features/chat/domain/usecases/chat_base_use_case.dart';
import '../features/chat/domain/usecases/chat_use_case.dart';
import '../features/chat/presentation/cubit/chat_cubit.dart';
import '../features/search/data/data_source/search_remote_data_source.dart';
import '../features/search/data/repository/search_repo_impl.dart';
import '../features/search/domain/repository/search_repo.dart';
import '../features/search/domain/usecases/search_base_use_case.dart';
import '../features/search/domain/usecases/search_use_case.dart';
import '../features/search/presentation/cubit/cubit/search_cubit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../core/cubit/short_users_cubit/short_users_cubit.dart';
import '../core/data/remote/core_remote.dart';
import '../core/data/repo/core_repo_impl.dart';
import '../core/domain/repo/core_repo.dart';
import '../core/domain/usecases/core_base_use_case.dart';
import '../core/domain/usecases/core_use_case.dart';
import '../features/auth/data/data_sources/auth_remote.dart';
import '../features/auth/data/repository/auth_repo_impl.dart';
import '../features/auth/domain/repository/auth_repo.dart';
import '../features/auth/domain/usecases/auth_base_use_case.dart';
import '../features/auth/domain/usecases/auth_use_case.dart';
import '../features/auth/presentation/cubit/auth_cubit/auth_cubit.dart';
import '../features/comments/data/data_sources/comment_remote.dart';
import '../features/comments/data/repository/comment_repo_impl.dart';
import '../features/comments/domain/repository/comment_repo.dart';
import '../features/comments/domain/usecases/comment_base_use_case.dart';
import '../features/comments/domain/usecases/comment_use_case.dart';
import '../features/comments/presentation/cubit/add_comment/add_comment_cubit.dart';
import '../features/comments/presentation/cubit/get_all_comments/get_all_comments_cubit.dart';
import '../features/notifications/data/data_sources/notification_remote.dart';
import '../features/notifications/data/repo/notification_repo_impl.dart';
import '../features/notifications/domain/repo/notification_repo.dart';
import '../features/notifications/domain/usecases/notification_base_usecase.dart';
import '../features/notifications/domain/usecases/notification_usecases.dart';
import '../features/notifications/presentation/cubit/cubit/notification_cubit.dart';
import '../features/post/data/data_sources/posts_remote.dart';
import '../features/post/data/repository/posts_repo_impl.dart';
import '../features/post/domain/repository/posts_repo.dart';
import '../features/post/domain/usecases/posts_base_use_case.dart';
import '../features/post/domain/usecases/posts_use_case.dart';
import '../features/post/presentation/cubit/post_cubit/post_cubit.dart';
import '../features/profile/data/data_sources/profile_remote.dart';
import '../features/profile/data/repository/profile_repo_impl.dart';
import '../features/profile/domain/repository/profile_repo.dart';
import '../features/profile/domain/usecases/profile_base_use_case.dart';
import '../features/profile/domain/usecases/profile_use_case.dart';
import '../features/profile/presentation/cubit/profile_data/profile_data_cubit.dart';
import '../features/story/data/remote/story_remote.dart';
import '../features/story/data/repository/story_repo_impl.dart';
import '../features/story/domain/repository/story_repo.dart';
import '../features/story/domain/usecases/story_base_use_case.dart';
import '../features/story/domain/usecases/story_use_case.dart';
import '../features/story/presentation/cubit/cubit/story_cubit_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
//! Core :

  //! Cubit :
  sl.registerFactory(() => ShortUsersCubit(sl()));

  //! Use case :
  sl.registerLazySingleton<CoreBaseUseCase>(() => CoreUseCase(sl()));

  //! Repo :
  sl.registerLazySingleton<CoreRepo>(() => CoreRepoImpl(sl()));

  //! Remote :
  sl.registerLazySingleton<CoreRemote>(() => CoreRemoteImpl());

  //! packages :
  final supabase = Supabase.instance.client;
  sl.registerLazySingleton<SupabaseClient>(() => supabase);

//! Features

  //! Start auth feature :
  //! Cubit :
  sl.registerFactory(() => AuthCubit(sl()));

  //! Use case :
  sl.registerLazySingleton<AuthBaseUseCase>(() => AuthUseCase(sl()));

  //! Repo :
  sl.registerLazySingleton<AuthRepo>(() => AuthRepoImpl(remote: sl()));

  //! Remote :
  sl.registerLazySingleton<AuthRemote>(() => AuthRemoteImpl());

  //! End feature auth .

  //! Start posts feature :
  //! Cubits :
  sl.registerFactory(() => PostCubit(sl()));

  //! Use case:
  sl.registerLazySingleton<PostsBaseUseCase>(() => PostsUseCase(sl()));

  //! Repo :
  sl.registerLazySingleton<PostsRepo>(() => PostsRepoImpl(sl()));

  //! Remote :
  sl.registerLazySingleton<PostsRemote>(() => PostsRemoteImpl());

  //! End feature posts .

  //! Start feature comment :
  //! Cubit :
  sl.registerFactory(() => GetAllCommentsCubit(sl()));
  sl.registerFactory(() => AddCommentCubit(sl()));

  //! Use cases :
  sl.registerLazySingleton<CommentBaseUsecase>(
      () => CommentUsecase(repo: sl()));

  //! Repo :
  sl.registerLazySingleton<CommentRepo>(() => CommentRepoImpl(sl()));

  //! Remote :
  sl.registerLazySingleton<CommentRemote>(() => CommentRemoteImpl());

  //! End feature comments

  //! Start feature profile :
  //! cubit :
  sl.registerFactory(() => ProfileCubit(sl()));

  //! Use case :
  sl.registerLazySingleton<ProfileBaseUsecase>(() => ProfileUsecase(sl()));

  //! Repo :
  sl.registerLazySingleton<ProfileRepo>(() => ProfileRepoImpl(sl()));

  //! Remote :
  sl.registerLazySingleton<ProfileRemote>(() => ProfileRemoteImpl());
  //! End feature profile

  //! Start feature story :
  //! cubit :
  sl.registerFactory(() => StoryCubit(sl()));

  //! Use case :
  sl.registerLazySingleton<StoryBaseUsecase>(() => StoryUsecase(repo: sl()));

  //! Repo :
  sl.registerLazySingleton<StoryRepo>(() => StoryRepoImpl(remote: sl()));

  //! Remote :
  sl.registerLazySingleton<StoryRemote>(() => StoryRemoteImpl());

  //! End feature story

  //! Start feature notification :

  //! Cubit :
  sl.registerFactory(() => NotificationCubit(sl()));

  //! Usecase :
  sl.registerLazySingleton<NotificationBaseUsecase>(
      () => NotificationUsecases(sl()));

  //! Repo :
  sl.registerLazySingleton<NotificationRepo>(() => NotificationRepoImpl(sl()));

  //! Remote :
  sl.registerLazySingleton<NotificationRemote>(() => NotificationRemoteImpl());

  //! End feature notification

  //! Start feature chat :

  //! Cubit :
  sl.registerFactory(() => ChatCubit(sl()));

  //! Usecases:
  sl.registerLazySingleton<ChatBaseUseCase>(() => ChatUseCase(repo: sl()));

  //! Repo :
  sl.registerLazySingleton<ChatRepo>(() => ChatRepoImpl(remote: sl()));

  //! Remote :
  sl.registerLazySingleton<ChatRemote>(() => ChatRemoteImpl(supabaseClient: sl()));

  //! End feature chat 

  //! Start feature search : 
  //! Cubit :
  sl.registerFactory(() => SearchCubit(sl()));

  //! Usecases:
  sl.registerLazySingleton<SearchBaseUseCase>(() => SearchUseCase(sl()));

  //! Repo :
  sl.registerLazySingleton<SearchRepo>(() => SearchRepoImpl( sl()));

  //! Remote :
  sl.registerLazySingleton<SearchRemoteDataSource>(() => SearchRemoteDataSourceImpl());

  //! End feature search 

}
