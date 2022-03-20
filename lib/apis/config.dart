// Define api base url for different environment
const BASE_URL = bool.fromEnvironment('dart.vm.product')
    ? 'https://csi5112group1project-service.kevinhe.dev/api'
    : 'https://localhost:7098/api';
