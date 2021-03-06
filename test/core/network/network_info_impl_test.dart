import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter_number_trivia_standalone/core/network/network_info_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockDataConnectionChecker extends Mock implements DataConnectionChecker {}

void main() {
  NetworkInfoImpl networkInfo;
  MockDataConnectionChecker mockDataConnectionChecker;

  setUp(() {
    mockDataConnectionChecker = MockDataConnectionChecker();
    networkInfo = NetworkInfoImpl(mockDataConnectionChecker);
  });

  group('isConnected', () {
    test(
      'should forward the call to DataConnectionChecker.hasConnection',
      () async {
        // arrange
        final testHasConnectionFuture = Future.value(true);
        when(mockDataConnectionChecker.hasConnection).thenAnswer((_) => testHasConnectionFuture);

        // act
        final result = networkInfo.isConnected;

        // assert
        verify(mockDataConnectionChecker.hasConnection);
        expect(result, testHasConnectionFuture);
      },
    );
  });
}
