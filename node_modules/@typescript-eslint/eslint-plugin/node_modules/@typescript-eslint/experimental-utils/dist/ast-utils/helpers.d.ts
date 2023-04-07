import { AST_NODE_TYPES, TSESTree } from '../ts-estree';
export declare const isNodeOfType: <NodeType extends AST_NODE_TYPES>(nodeType: NodeType) => (node: TSESTree.Node | null | undefined) => node is TSESTree.Node & {
    type: NodeType;
};
export declare const isNodeOfTypes: <NodeTypes extends readonly AST_NODE_TYPES[]>(nodeTypes: NodeTypes) => (node: TSESTree.Node | null | undefined) => node is TSESTree.Node & {
    type: NodeTypes[number];
};
export declare const isNodeOfTypeWithConditions: <NodeType extends AST_NODE_TYPES, Conditions extends Partial<TSESTree.Node & {
    type: NodeType;
}>>(nodeType: NodeType, conditions: Conditions) => (node: TSESTree.Node | null | undefined) => node is TSESTree.Node & {
    type: NodeType;
} & Conditions;
//# sourceMappingURL=helpers.d.ts.map