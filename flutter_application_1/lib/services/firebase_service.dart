import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  // Use static instances to avoid multiple initializations
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Cache for user data to reduce Firestore reads
  Map<String, dynamic>? _cachedUserData;
  String? _cachedUserId;

  // Mock user for testing without Firebase
  static final Map<String, dynamic> _mockUser = {
    'uid': 'mock-user-id',
    'email': 'test@example.com',
    'name': 'Test User',
  };

  // Flag to use mock authentication
  static const bool _useMockAuth = true;

  // Get current user
  User? get currentUser => _useMockAuth ? null : _auth.currentUser;

  // Check if user is logged in
  bool get isLoggedIn => _useMockAuth ? false : _auth.currentUser != null;

  // Sign in with email and password
  Future<UserCredential> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    if (_useMockAuth) {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));

      // Simulate successful login
      if (email == 'test@example.com' && password == 'password') {
        return MockUserCredential();
      } else {
        throw FirebaseAuthException(
          code: 'user-not-found',
          message: 'No user found with this email.',
        );
      }
    }

    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      rethrow;
    }
  }

  // Sign up with email and password
  Future<UserCredential> signUpWithEmailAndPassword(
    String email,
    String password,
  ) async {
    if (_useMockAuth) {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));

      // Simulate successful signup
      return MockUserCredential();
    }

    try {
      return await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      rethrow;
    }
  }

  // Sign out
  Future<void> signOut() async {
    _cachedUserData = null;
    _cachedUserId = null;

    if (!_useMockAuth) {
      await _auth.signOut();
    }
  }

  // Get user data from Firestore with caching
  Future<Map<String, dynamic>?> getUserData(String userId) async {
    if (_useMockAuth) {
      // Return mock user data
      return _mockUser;
    }

    // Return cached data if available and for the same user
    if (_cachedUserData != null && _cachedUserId == userId) {
      return _cachedUserData;
    }

    try {
      DocumentSnapshot doc =
          await _firestore.collection('users').doc(userId).get();
      if (doc.exists) {
        _cachedUserData = doc.data() as Map<String, dynamic>;
        _cachedUserId = userId;
        return _cachedUserData;
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  // Update user data in Firestore
  Future<void> updateUserData(
    String userId,
    Map<String, dynamic> userData,
  ) async {
    if (_useMockAuth) {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 500));
      return;
    }

    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .set(userData, SetOptions(merge: true));

      // Update cache
      if (_cachedUserId == userId) {
        _cachedUserData = {...?_cachedUserData, ...userData};
      }
    } catch (e) {
      rethrow;
    }
  }

  // Create a new user document in Firestore
  Future<void> createUserDocument(
    String userId,
    Map<String, dynamic> userData,
  ) async {
    if (_useMockAuth) {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 500));
      return;
    }

    try {
      await _firestore.collection('users').doc(userId).set(userData);

      // Update cache
      _cachedUserData = userData;
      _cachedUserId = userId;
    } catch (e) {
      rethrow;
    }
  }
}

// Mock UserCredential class for testing
class MockUserCredential implements UserCredential {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);

  @override
  User? get user => MockUser();
}

// Mock User class for testing
class MockUser implements User {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);

  @override
  String get uid => 'mock-user-id';

  @override
  String? get email => 'test@example.com';
}
