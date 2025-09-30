import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_loading_indicator.dart';
import '../../../../shared/providers/auth_provider.dart';
import '../../../../shared/models/auth_state.dart';
import '../../../../shared/models/user.dart';
import '../../../../core/utils/helpers.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  bool _isEditing = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadUserData();
  }

  void _loadUserData() {
    final user = ref.read(authProvider).user;
    if (user != null) {
      _nameController.text = user.name;
      _emailController.text = user.email;
      _phoneController.text = user.phone ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('profile'.tr()),
        actions: [
          if (!_isEditing)
            TextButton(
              onPressed: () => setState(() => _isEditing = true),
              child: Text('edit'.tr()),
            )
          else
            TextButton(
              onPressed: () => setState(() => _isEditing = false),
              child: Text('cancel'.tr()),
            ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 32),

              // Profile Avatar
              Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Theme.of(context).primaryColor,
                  child: authState.user?.hasAvatar == true
                      ? ClipOval(
                          child: CachedNetworkImage(
                            imageUrl: authState.user!.avatar!,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => const AppLoadingIndicator(),
                            errorWidget: (context, url, error) => Text(
                              authState.user?.initials ?? 'U',
                              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      : Text(
                          authState.user?.initials ?? 'U',
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color: Colors.white,
                          ),
                        ),
                ),
              ),

              const SizedBox(height: 32),

              // Profile Form
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Name Field
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'full_name'.tr(),
                        prefixIcon: const Icon(Icons.person),
                        enabled: _isEditing,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'name_required'.tr();
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    // Email Field
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'email'.tr(),
                        prefixIcon: const Icon(Icons.email),
                        enabled: _isEditing,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'email_required'.tr();
                        }
                        if (!Helpers.isValidEmail(value)) {
                          return 'email_invalid'.tr();
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    // Phone Field
                    TextFormField(
                      controller: _phoneController,
                      decoration: InputDecoration(
                        labelText: 'phone'.tr(),
                        hintText: 'enter_phone'.tr(),
                        prefixIcon: const Icon(Icons.phone),
                        enabled: _isEditing,
                      ),
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value != null && value.isNotEmpty && !Helpers.isValidPhone(value)) {
                          return 'phone_invalid'.tr();
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 32),

                    if (_isEditing) ...[
                      // Save Button
                      AppButton(
                        text: 'save'.tr(),
                        onPressed: _handleSave,
                        type: AppButtonType.primary,
                      ),

                      const SizedBox(height: 16),

                      // Cancel Button
                      AppButton(
                        text: 'cancel'.tr(),
                        onPressed: () => setState(() => _isEditing = false),
                        type: AppButtonType.outline,
                      ),
                    ] else ...[
                      // Edit Profile Button
                      AppButton(
                        text: 'edit_profile'.tr(),
                        onPressed: () => setState(() => _isEditing = true),
                        type: AppButtonType.outline,
                      ),

                      const SizedBox(height: 16),

                      // Change Password Button
                      AppButton(
                        text: 'change_password'.tr(),
                        onPressed: _handleChangePassword,
                        type: AppButtonType.text,
                      ),

                      const SizedBox(height: 16),

                      // Delete Account Button
                      AppButton(
                        text: 'delete_account'.tr(),
                        onPressed: _handleDeleteAccount,
                        type: AppButtonType.danger,
                      ),
                    ],
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Account Info
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'account_info'.tr(),
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'member_since'.tr() + ': ${authState.user?.createdAt?.toString().split(' ')[0] ?? 'N/A'}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Text(
                      'last_updated'.tr() + ': ${authState.user?.updatedAt?.toString().split(' ')[0] ?? 'N/A'}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleSave() async {
    if (_formKey.currentState!.validate()) {
      try {
        final currentState = ref.read(authProvider);
        final updatedUser = currentState.user!.copyWith(
          name: _nameController.text.trim(),
          email: _emailController.text.trim(),
          phone: _phoneController.text.trim(),
          updatedAt: DateTime.now(),
        );

        // Update in service
        // await ref.read(authServiceProvider).updateProfile(updatedUser);

        // Update in provider
        ref.read(authProvider.notifier).state = currentState.copyWith(user: updatedUser);

        setState(() => _isEditing = false);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('profile_updated'.tr())),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('update_failed'.tr()),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _handleChangePassword() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('change_password_feature'.tr())),
    );
  }

  void _handleDeleteAccount() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('delete_account'.tr()),
        content: Text('delete_account_confirmation'.tr()),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('cancel'.tr()),
          ),
          TextButton(
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('delete'.tr()),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        // await ref.read(authServiceProvider).deleteAccount();
        // await ref.read(authProvider.notifier).logout();

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('account_deleted'.tr())),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('delete_failed'.tr()),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
