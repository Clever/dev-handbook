"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.isNodeOfTypeWithConditions = exports.isNodeOfTypes = exports.isNodeOfType = void 0;
const isNodeOfType = (nodeType) => (node) => (node === null || node === void 0 ? void 0 : node.type) === nodeType;
exports.isNodeOfType = isNodeOfType;
const isNodeOfTypes = (nodeTypes) => (node) => !!node && nodeTypes.includes(node.type);
exports.isNodeOfTypes = isNodeOfTypes;
const isNodeOfTypeWithConditions = (nodeType, conditions) => {
    const entries = Object.entries(conditions);
    return (node) => (node === null || node === void 0 ? void 0 : node.type) === nodeType &&
        entries.every(([key, value]) => node[key] === value);
};
exports.isNodeOfTypeWithConditions = isNodeOfTypeWithConditions;
//# sourceMappingURL=helpers.js.map