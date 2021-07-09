package hxlovr;

import lua.UserData;
import haxe.extern.Rest;
import haxe.extern.EitherType;
import haxe.Constraints.Function;

typedef ModulesConfig = {
    var ?audio: Bool;
    var ?data: Bool;
    var ?event: Bool;
    var ?filesystem: Bool;
    var ?graphics: Bool;
    var ?headset: Bool;
    var ?math: Bool;
    var ?physics: Bool;
    var ?system: Bool;
    var ?thread: Bool;
    var ?timer: Bool;
};

typedef AudioConfig = {
    var ?spatializer: String;
    var ?start: Bool;
};

typedef GraphicsConfig = {
    var ?debug: Bool;
};

typedef HeadsetConfig = {
    var ?drivers: Array<String>;
    var ?supersample: EitherType<Float, Bool>;
    var ?offset: Float;
    var ?msaa: Int;
};

typedef MathConfig = {
    var ?globals: Bool;
};

typedef WindowConfig = {
    var ?width: Int;
    var ?height: Int;
    var ?fullscreen: Bool;
    var ?resizable: Bool;
    var ?msaa: Int;
    var ?title: String;
    var ?icon: String;
    var ?vsync: EitherType<Bool, Int>;
};

typedef Config = {
    var ?version: String;
    var ?identity: String;
    var ?saveprecedence: Bool;
    var ?modules: ModulesConfig;
    var ?audio: AudioConfig;
    var ?graphics: GraphicsConfig;
    var ?headset: HeadsetConfig;
    var ?math: MathConfig;
    var ?window: WindowConfig;
};

@:multiReturn
extern class LovrVersion {
    var major: Int;
    var mainor: Int;
    var match: Int;
}

typedef LovrSourceOptions = {
    var ?decode: Bool;
    var ?effects: EitherType<Bool, Array<Dynamic>>;
}

@:multiReturn
extern class LovrFrames {
    var t_or_count(default, null): EitherType<Array<Dynamic>, Int>;
    var num(default, null): Int;
}

extern class LovrSound {
    public function new();
    public function getBlob(): LovrBlob;
    public function getChannelCount(): Int;
    public function getChannelLayout(): EitherType<String, LovrChannelLayout>;
    public function isCompressed(): Bool;
    public function getDuration(): Float;
    public function getFormat(): EitherType<String, LovrSampleFormat>;
    public function getFrameCount(): Int;
    public function getFrames(?data_or_count: EitherType<EitherType<Int, Array<Dynamic>>, EitherType<LovrBlob, LovrSound>>, ?offset_or_count: Int, ?srcOffset: Int = 0, ?dstOffset: Int = 0): LovrFrames;
    public function setFrames(?data: EitherType<Array<Dynamic>, EitherType<LovrBlob, LovrSound>>, ?count: Int, ?srcOffset: Int = 0, ?dstOffset: Int = 0): Int;
    public function getSampleCount(): Int;
    public function isStream(): Bool;
}

@:enum abstract LovrTimeUnit(String) {
    var SECONDS = "seconds";
    var FRAMES = "frames";
}

@:enum abstract LovrVolumeUnit(String) {
    var LINEAR = "linear";
    var DB = "db";
}

@:multiReturn
extern class LovrDirectivity {
    var weight: Float;
    var power: Float;
}

@:enum abstract LovrEffect(String) {
    var SPATIALIZATION = "spatialization";
    var ATTENUATION = "attenuation";
    var ABSORPTION = "absorption";
    var OCCLUSION = "occlusion";
    var TRANSMISSION = "transmission";
    var REVERB = "reverb";
    var FALLOFF = "falloff";
}

extern class LovrSource {
    public function new();
    public function clone(): LovrSource;
    public function getDuration(?unit: EitherType<String, LovrTimeUnit> = LovrTimeUnit.SECONDS): Float;
    public function isLooping(): Bool;
    public function setLooping(loop: Bool): Void;
    public function pause(): Void;
    public function play(): Void;
    public function isPlaying(): Void;
    public function seek(?position: Int, ?unit: EitherType<String, LovrTimeUnit> = LovrTimeUnit.SECONDS): Void;
    public function stop(): Void;
    public function tell(?unit: LovrTimeUnit = LovrTimeUnit.SECONDS): Int;
    public function getVolume(?unit: EitherType<String, LovrVolumeUnit> = LovrVolumeUnit.LINEAR): Float;
    public function setVolume(?volume: Float, ?unit: EitherType<String, LovrVolumeUnit> = LovrVolumeUnit.LINEAR): Void;
    public function getDirectivity(): LovrDirectivity;
    public function setDirectivity(weight: Float, power: Float): Void;
    public function isEffectEnabled(effect: EitherType<EitherType<String, Dynamic>, LovrEffect>): Bool;
    public function setEffectEnabled(effect: Dynamic, enable: Bool): Void;
    public function getOrientation(): LovrOrientation;
    public function setOrientation(angle: Float, ax: Float, ay: Float, az: Float): Void;
    public function getPose(): LovrPose;
    public function setPose(x: Float, y: Float, z: Float, angle: Float, ax: Float, ay: Float, az: Float): Void;
    public function getPosition(): LovrPos;
    public function setPosition(x: Float, y: Float, z: Float): Void;
    public function getRadius(): Float;
    public function setRadius(radius: Float): Void;
    public function getSound(): LovrSound;
}

@:enum abstract LovrAudioType(String) {
    var PLAYBACK = "playback";
    var CAPTURE = "capture";
}

@:enum abstract LovrAudioShareMode(String) {
    var SHARED = "shared";
    var EXCLUSIVE = "exclusive";
}

/*
typedef LovrAudioDevice = {
    var ?id: UserData;
    var ?name: String;
    var ?default: Bool;
}
*/

@:enum abstract LovrAudioMaterial(String) {
    var GENERIC = "generic";
    var BRICK = "brick";
    var CARPET = "carpet";
    var CERAMIC = "ceramic";
    var CONCRETE = "concrete";
    var GLASS = "glass";
    var GRAVEL = "gravel";
    var METAL = "metal";
    var PLASTER = "plaster";
    var ROCK = "rock";
    var WOOD = "wood";
}

extern class LovrAudioModule {
    public function new();
    @:luaDotMethod public function newSource(?source: EitherType<String, EitherType<LovrBlob, LovrSound>>, ?options: LovrSourceOptions): LovrSource;
    @:luaDotMethod public function setGeometry(?vertices_or_model: EitherType<Array<Float>, LovrModel>, ?indices_or_material: EitherType<Array<Int>, EitherType<String, LovrAudioMaterial>>, ?material: EitherType<String, LovrAudioMaterial> = LovrAudioMaterial.GENERIC): Bool;
    @:luaDotMethod public function getOrientation(): LovrOrientation;
    @:luaDotMethod public function setOrientation(angle: Float, ax: Float, ay: Float, az: Float): Void;
    @:luaDotMethod public function getPose(): LovrPose;
    @:luaDotMethod public function setPose(x: Float, y: Float, z: Float, angle: Float, ax: Float, ay: Float, az: Float): Void;
    @:luaDotMethod public function getPosition(): LovrPos;
    @:luaDotMethod public function setPosition(x: Float, y: Float, z: Float): Void;
    @:luaDotMethod public function getSpatializer(): String;
    @:luaDotMethod public function getVolume(?unit: EitherType<String, LovrVolumeUnit> = LovrVolumeUnit.LINEAR): Float;
    @:luaDotMethod public function setVolume(?volume: Float, ?unit: EitherType<String, LovrVolumeUnit> = LovrVolumeUnit.LINEAR): Void;
    @:luaDotMethod public function setDevice(?type: EitherType<String, LovrAudioType> = LovrAudioType.PLAYBACK, ?id: UserData, ?sink: LovrSound, ?mode: EitherType<String, LovrAudioShareMode> = LovrAudioShareMode.SHARED): Bool;
    @:luaDotMethod public function getDevices(?type: EitherType<String, LovrAudioType> = LovrAudioType.PLAYBACK): Array<Dynamic>;
    @:luaDotMethod public function start(?type: EitherType<String, LovrAudioType> = LovrAudioType.PLAYBACK): Bool;
    @:luaDotMethod public function isStarted(?type: EitherType<String, LovrAudioType> = LovrAudioType.PLAYBACK): Bool;
    @:luaDotMethod public function stop(?type: EitherType<String, LovrAudioType> = LovrAudioType.PLAYBACK): Bool;
}

extern class LovrRasterizer {
    public function new();
    public function getAdvance(): Float;
    public function getAscent(): Float;
    public function getDescent(): Float;
    public function getGlyphCount(): Int;
    public function hasGlyphs(glyphs: Rest<String>): Bool;
    public function getHeight(): Int;
    public function getLineHeight(): Int;
}

@:enum abstract LovrSampleFormat(String) {
    var F32 = "f32";
    var I16 = "i16";
}

@:enum abstract LovrChannelLayout(String) {
    var MONO = "mono";
    var STEREO = "stereo";
    var AMBISONIC = "ambisonic";
}

extern class LovrDataModule {
    public function new();
    @:luaDotMethod public function newBlob(?size: Int, ?name: String = ''): LovrBlob;
    @:luaDotMethod public function newImage(?filename: String, ?flipped: Bool): LovrImage;
    @:luaDotMethod public function newModelData(filename: String): UserData;
    @:luaDotMethod public function newRasterizer(?arg1: EitherType<EitherType<Int, String>, LovrBlob>, ?arg2: Int): LovrRasterizer;
    @:luaDotMethod public function newSound(?frames_or_filename_or_blob: EitherType<EitherType<Int, String>, LovrBlob>, ?format_or_decode: EitherType<EitherType<String, LovrSampleFormat>, Bool>, channels: EitherType<String, LovrChannelLayout>, ?sampleRate: Int = 48000, contents: Dynamic): LovrSound;
}

extern class LovrEventModule {
    public function new();
    @:luaDotMethod public function clear(): Void;
    @:luaDotMethod public function poll(): Array<Dynamic>;
    @:luaDotMethod public function pump(): Void;
    @:luaDotMethod public function push(name: String, args: Rest<Dynamic>): Void;
    @:luaDotMethod public function quit(?code: Int = 0): Void;
    @:luaDotMethod public function restart(): Void;
}

@:multiReturn
extern class LovrReadData {
    var content: String;
    var bytes: Int;
}

extern class LovrFilesystemModule {
    public function new();
    @:luaDotMethod public function append(filename: String, content: String): Int;
    @:luaDotMethod public function createDirectory(path: String): Bool;
    @:luaDotMethod public function getAppdataDirectory(): String;
    @:luaDotMethod public function getDirectoryItems(path: String): Array<String>;
    @:luaDotMethod public function getExecutablePath(): String;
    @:luaDotMethod public function getIdentity(): String;
    @:luaDotMethod public function getLastModified(path: String): Float;
    @:luaDotMethod public function getRealDirectory(path: String): String;
    @:luaDotMethod public function getRequirePath(): String;
    @:luaDotMethod public function getSaveDirectory(): String;
    @:luaDotMethod public function getSize(file: String): Int;
    @:luaDotMethod public function getSource(): String;
    @:luaDotMethod public function getUserDirectory(): String;
    @:luaDotMethod public function getWorkingDirectory(): String;
    @:luaDotMethod public function isDirectory(path: String): Bool;
    @:luaDotMethod public function isFile(path: String): Bool;
    @:luaDotMethod public function isFused(): Bool;
    @:luaDotMethod public function load(filename: String): haxe.Constraints.Function;
    @:luaDotMethod public function mount(?path: String, ?mountpoint: String = "/", ?append: Bool = false, ?root: String): Bool;
    @:luaDotMethod public function newBlob(filename: String): LovrBlob;
    @:luaDotMethod public function read(filename: String, ?bytes: Int = -1): LovrReadData;
    @:luaDotMethod public function remove(path: String): Bool;
    @:luaDotMethod public function setIdentity(identity: String): Void;
    @:luaDotMethod public function setRequirePath(path: String): Void;
    @:luaDotMethod public function setSource(identity: String): Void;
    @:luaDotMethod public function unmount(path: String): Bool;
    @:luaDotMethod public function write(filename: String, content: String): Int;
}

@:enum abstract LovrHorizontalAlign(String) {
    var LEFT = "left";
    var CENTER = "center";
    var RIGHT = "right";
}

@:enum abstract LovrVerticalAlign(String) {
    var TOP = "top";
    var MIDDLE = "middle";
    var BOTTOM = "bottom";
}

@:enum abstract LovrDrawStyle(String) {
    var FILL = "fill";
    var LINE = "line";
}

@:enum abstract LovrArcMode(String) {
    var PIE = "pie";
    var OPEN = "open";
    var CLOSED = "closed";
}

@:enum abstract LovrUniformAccess(String) {
    var READ = "read";
    var WRITE = "write";
    var READWRITE = "readwrite";
}

@:enum abstract LovrShaderType(String) {
    var UNIFORM = "uniform";
    var COMPUTE = "compute";
}

extern class LovrShaderBlock {
    public function new();
    public function getOffset(field: String): Int;
    public function read(name: String): Dynamic;
    public function name(variable_or_blob: EitherType<String, LovrBlob>, value_or_offset: Any, ?extent: Int): EitherType<Void, Int>;
    public function getShaderCode(?label: String, ?namespace: String): String;
    public function getSize(): Int;
    public function getType(): EitherType<String, LovrShaderType>;
}

extern class LovrShader {
    public function new();
    public function hasBlock(block: String): Bool;
    public function hasUniform(uniform: String): Bool;
    public function send(uniform: String, value: Any): Bool;
    public function sendBlock(name: String, block: LovrShaderBlock, ?access: EitherType<String, LovrUniformAccess> = LovrUniformAccess.READWRITE): Void;
    public function sendImage(v1: String, v2: EitherType<LovrTexture, Int>, v3: EitherType<LovrTexture, Any>, v4: EitherType<Int, Any>, v5: EitherType<EitherType<String, LovrUniformAccess>, Int>, v5: EitherType<String, LovrUniformAccess>): Void;
    public function getType(): EitherType<String, LovrShaderType>;
}

@:enum abstract LovrStencilAction(String) {
    var REPLACE = "replace";
    var INCREMENT = "increment";
    var DECREMENT = "decrement";
    var INCREMENTWRAP = "incrementwrap";
    var DECREMENTWRAP = "decrementwrap";
    var INVERT = "invert";
}

extern class LovrCanvas {
    public function new();
    public function getDepthTexture(): LovrTexture;
    public function getDimensions(): LovrDimensions;
    public function getHeight(): Int;
    public function getMSAA(): Int;
    public function newImage(?index: Int = 1): LovrImage;
    public function renderTo(callback: haxe.Constraints.Function, args: Rest<Any>): Void;
    public function isStereo(): Bool;
    public function getTexture(): Rest<LovrTexture>;
    public function setTexture(textures: Rest<LovrTexture>): Void;
    public function getWidth(): Int;
}

@:multiReturn
extern class LovrFontWidth {
    var width: Float;
    var lines: Int;
}

extern class LovrFont {
    public function new();
    public function getAscent(): Float;
    public function getBaseline(): Float;
    public function getDescent(): Float;
    public function hasGlyphs(glyphs: Rest<Any>): Bool;
    public function getHeight(): Float;
    public function getLineHeight(): Float;
    public function setLineHeight(lineHeight: Float): Void;
    public function getPixelDensity(): Float;
    public function setPixelDensity(pixelDensity: Float): Void;
    public function getRasterizer(): LovrRasterizer;
    public function getWidth(text: String, ?wrap: Float = 0): LovrFontWidth;
}

@:enum abstract LovrDrawMode(String) {
    var POINTS = "points";
    var LINES = "lines";
    var LINESTRIP = "linestrip";
    var LINELOOP = "lineloop";
    var STRIP = "strip";
    var TRIANGLES = "triangles";
    var FAN = "fan";
}

@:multiReturn
extern class LovrDrawRange {
    var start: Int;
    var count: Int;
}

@:enum abstract LovrAttributeType(String) {
    var BYTE = "byte";
    var UBYTE = "ubyte";
    var SHORT = "short";
    var USHORT = "ushort";
    var INT = "int";
    var UINT = "uint";
    var FLOAT = "float";
}

extern class LovrMesh {
    public function new();
    public function attachAttributes(args: Rest<Any>): Void;
    public function isAttributeEnabled(attribute: String): Bool;
    public function setAttributeEnabled(attribute: String, enabled: Bool): Void;
    public function detachAttributes(mesh: LovrMesh, args: Rest<Any>): Void;
    public function draw(x_or_transform: EitherType<Float, LovrMat4>, ?y_or_instances: EitherType<Float, Int>, z: Float, scale: Float, angle: Float, ax: Float, ay: Float, az: Float, instances: Int): Void;
    public function getDrawMode(): EitherType<String, LovrDrawMode>;
    public function setDrawMode(mode: EitherType<String, LovrDrawMode>): Void;
    public function getDrawRange(): LovrDrawRange;
    public function setDrawRange(start: Int, count: Int): Void;
    public function getMaterial(): LovrMaterial;
    public function setMaterial(material: LovrMaterial): Void;
    public function getVertex(index: Int): Rest<Float>;
    public function setVertex(index: Int, args: Rest<Any>): Void;
    public function getVertexAttribute(index: Int, attribute: Int): Rest<Float>;
    public function setVertexAttribute(index: Int, attribute: Int, args: Rest<Float>): Void;
    public function getVertexCount(): Int;
    public function getVertexFormat(): Array<Dynamic>;
    public function getVertexMap(?data: Dynamic): Array<Dynamic>;
    public function setVertices(?data: EitherType<Array<Dynamic>, LovrBlob>, ?start: Int = 1, ?count: Int): Void;

}

typedef LovrShaderOptions = {
    var flags: Array<Any>;
};

@:enum abstract LovrBlendMode(String) {
    var ALPHA = "alpha";
    var ADD = "add";
    var SUBTRACT = "subtract";
    var MULTIPLY = "multiply";
    var LIGHTEN = "lighten";
    var DARKEN = "darken";
    var SCREEN = "screen";
}

@:enum abstract LovrBlendAlphaMode(String) {
    var ALPHAMULTIPLY = "alphamultiply";
    var PREMULTIPLIED = "premultiplied";
}

@:multiReturn
extern class LovrBlendInfo {
    var blend: EitherType<String, LovrBlendMode>;
    var alphaBlend: EitherType<String, LovrBlendAlphaMode>;
}

@:multiReturn
extern class LovrDepthInfo {
    var compareMode: EitherType<String, LovrCompareMode>;
    var write: Bool;
}

typedef LovrGraphicsStats = {
    var ?drawcalls: Int;
    var ?renderpasses: Int;
    var ?shaderswitches: Int;
    var ?buffers: Int;
    var ?textures: Int;
    var ?buffermemory: Int;
    var ?texturememory: Int;
}

@:multiReturn
extern class LovrStrencilInfo {
    var compareMode(default, null): EitherType<String, LovrCompareMode>;
    var compareValue(default, null): Float;
}

@:enum abstract LovrWinding(String) {
    var CLOCKWISE = "clockwise";
    var COUNTERCLOCKWISE = "counterclockwise";
}

typedef LovrWindowFlags = {
    var ?width: Int;
    var ?height: Int;
    var ?fullscreen: Bool;
    var ?resizable: Bool;
    var ?msaa: Int;
    var ?title: String;
    var ?icon: String;
    var ?vsync: Int;
}

typedef LovrGraphicsFeatures = {
    var ?astc: Bool;
    var ?compute: Bool;
    var ?dxt: Bool;
    var ?instancedstereo: Bool;
    var ?multiview: Bool;
    var ?timers: Bool;
}

typedef LovrGraphicsLimits = {
    var ?anisotropy: Float;
    var ?blocksize: Int;
    var ?pointsize: Float;
    var ?texturemsaa: Int;
    var ?texturesize: Float;
    var ?compute: Array<Int>;
}

extern class LovrGraphicsModule {
    public function new();
    @:luaDotMethod public function arc(?mode_or_material: EitherType<EitherType<String, LovrDrawStyle>, LovrMaterial>, ?v1: EitherType<EitherType<Float, LovrMat4>, EitherType<String, LovrArcMode>>, ?v2: EitherType<Float, LovrMat4>, ?v3: Float, ?v4: Float, ?v5: EitherType<Int, Float>, ?v6: Float, ?v7: Float, ?v8: Float, ?v9: Float, ?v10: Float, ?v11: Float, ?v12: EitherType<Float, Int>, ?v13: Int): Void;
    @:luaDotMethod public function box(?mode_or_material: EitherType<EitherType<String, LovrDrawStyle>, LovrMaterial>, ?x_or_transform: EitherType<Float, LovrMat4>, ?y: Float, ?z: Float, ?width: Float, ?height: Float, ?depth: Float, ?angle: Float, ?ax: Float, ?ay: Float, ?az: Float): Void;
    @:luaDotMethod public function circle(?mode_or_material: EitherType<EitherType<String, LovrDrawStyle>, LovrMaterial>, ?x_or_transform: EitherType<Float, LovrMat4>, ?y_or_segments: EitherType<Float, Int>, ?z: Float, ?radius: Float, ?angle: Float, ?ax: Float, ?ay: Float, ?az: Float, ?segments: Int): Void;
    @:luaDotMethod public function compute(?shader: LovrShader, ?x: Float = 1, ?y: Float = 1, ?z: Float = 1): Void;
    @:luaDotMethod public function cube(?mode_or_material: EitherType<EitherType<String, LovrDrawStyle>, LovrMaterial>, ?x_or_transform: EitherType<Float, LovrMat4>, ?y: Float, ?z: Float, ?size: Float, ?angle: Float, ?ax: Float, ?ay: Float, ?az: Float): Void;
    @:luaDotMethod public function cylinder(?v1: EitherType<Float, LovrMaterial>, ?v2: Float, ?v3: Float, ?v4: Float, ?v5: Float, ?v6: Float, ?v7: Float, ?v8: Float, ?v9: Float, ?v10: Float, ?v11: EitherType<Float, Bool>, ?v12: EitherType<Int, Bool>, ?v13: Int): Void;
    @:luaDotMethod public function discard(?color: Bool = true, ?depth: Bool = true, ?stencil: Bool = true): Void;
    @:luaDotMethod public function fill(?texture: LovrTexture, ?u: Float, ?v: Float, ?w: Float, ?h: Float): Void;
    @:luaDotMethod public function flush(): Void;
    @:luaDotMethod public function line(?x1_or_points: EitherType<Float, Array<Float>>, ?y1: Float, ?z1: Float, ?x2: Float, ?y2: Float, ?z2: Float, additional_points: Rest<Float>): Void;
    @:luaDotMethod public function plane(?mode_or_material: EitherType<EitherType<String, LovrDrawStyle>, LovrMaterial>, ?x: Float = 0, ?y: Float = 0, ?z: Float = 0, ?width: Float = 1, ?height: Float = 1, ?angle: Float = 0, ?ax: Float = 0, ?ay: Float = 1, ?az: Float = 0, ?u: Float = 0, ?v: Float = 0, ?w: Float, ?h: Float): Void;
    @:luaDotMethod public function points(?x_or_points: EitherType<Float, Array<Float>>, ?y: Float, ?z: Float, additional_points: Rest<Float>): Void;
    @:luaDotMethod public function print(str: String, ?x: Float = 0, ?y: Float = 0, ?z: Float = 0, ?scale: Float = 1, ?angle: Float = 0, ?ax: Float = 0, ?ay: Float = 1, ?az: Float = 0, ?wrap: EitherType<Float, Null<Float>>, ?halign: EitherType<String, LovrHorizontalAlign> = LovrHorizontalAlign.CENTER, ?valign: EitherType<String, LovrVerticalAlign> = LovrVerticalAlign.MIDDLE): Void;
    @:luaDotMethod public function skybox(texture: LovrTexture): Void;
    @:luaDotMethod public function sphere(?v1: EitherType<Float, LovrMaterial>, ?v2: Float, ?v3: Float, ?v4: Float, ?v5: Float, ?v6: Float, ?V7: Float, ?v8: Float, ?v9: Float): Void;
    @:luaDotMethod public function stencil(callback: haxe.Constraints.Function, ?action: EitherType<String, LovrStencilAction> = LovrStencilAction.REPLACE, ?value: Float, ?keep_or_initial: EitherType<Bool, Float>): Void;
    @:luaDotMethod public function newCanvas(args: Rest<Any>): LovrCanvas;
    @:luaDotMethod public function newComputeShader(source: String, ?options: LovrShaderOptions): LovrShader;
    @:luaDotMethod public function newFont(?v1: EitherType<String, EitherType<LovrRasterizer, Float>>, ?v2: Float, ?v3: Float, ?v4: Float): LovrFont;
    @:luaDotMethod public function newMaterial(args: Rest<Any>): LovrMaterial;
    @:luaDotMethod public function newMesh(args: Rest<Any>): LovrMesh;
    @:luaDotMethod public function newModel(filename: String): LovrModel;
    @:luaDotMethod public function newShader(args: Rest<Any>): LovrShader;
    @:luaDotMethod public function newShaderBlock(args: Rest<Any>): LovrShaderBlock;
    @:luaDotMethod public function newTexture(args: Rest<Any>): LovrTexture;
    @:luaDotMethod public function origin(): Void;
    @:luaDotMethod public function pop(): Void;
    @:luaDotMethod public function push(): Void;
    @:luaDotMethod public function rotate(?angle: Float = 0, ?ax: Float = 0, ?ay: Float = 1, ?az: Float = 0): Void;
    @:luaDotMethod public function scale(?x: Float = 1, ?y: Float = 0, ?z: Float = 0): Void;
    @:luaDotMethod public function transform(?x_or_transform: EitherType<Float, LovrMat4>, ?y: Float, ?z: Float, ?sx: Float, ?sy: Float, ?sz: Float, ?angle: Float, ?ax: Float, ?ay: Float, ?az: Float): Void;
    @:luaDotMethod public function translate(?x: Float = 0, ?y: Float = 0, ?z: Float = 0): Void;
    @:luaDotMethod public function getAlphaSampling(): Bool;
    @:luaDotMethod public function setAlphaSampling(enabled: Bool): Void;
    @:luaDotMethod public function getBackgroundColor(): LovrColor;
    @:luaDotMethod public function setBackgroundColor(?red_or_hex_or_table: EitherType<EitherType<Float, Int>, Array<Float>>, ?green: Float, ?blue: Float, ?alpha: Float = 1): Void;
    @:luaDotMethod public function getBlendMode(): LovrBlendInfo;
    @:luaDotMethod public function setBlendMode(?blend: EitherType<String, LovrBlendMode>, ?alphaBlend: EitherType<String, LovrBlendAlphaMode>): Void;
    @:luaDotMethod public function getCanvas(): LovrCanvas;
    @:luaDotMethod public function setCanvas(?canvas: LovrCanvas): Void;
    @:luaDotMethod public function getColor(): LovrColor;
    @:luaDotMethod public function setColor(?red_or_hex_or_table: EitherType<EitherType<Float, Int>, Array<Float>>, ?green: Float, ?blue: Float, ?alpha: Float = 1): Void;
    @:luaDotMethod public function getColorMask(): Void;
    @:luaDotMethod public function setColorMask(r: Bool, g: Bool, b: Bool, a: Bool): Void;
    @:luaDotMethod public function isCullingEnabled(): Bool;
    @:luaDotMethod public function setCullingEnabled(isEnabled: Bool): Void;
    @:luaDotMethod public function getDefaultFilter(): LovrFilter; 
    @:luaDotMethod public function setDefaultFilter(mode: EitherType<String, LovrFilter>, anisotropy: Float): Void; 
    @:luaDotMethod public function getDepthTest(): LovrDepthInfo;
    @:luaDotMethod public function setDepthTest(compareMode: LovrCompareMode, write: Bool): Void;
    @:luaDotMethod public function getFont(): LovrFont;
    @:luaDotMethod public function setFont(?font: LovrFont): Void;
    @:luaDotMethod public function getLineWidth(): Float;
    @:luaDotMethod public function setLineWidth(width: Float): Void;
    @:luaDotMethod public function getPointSize(): Float;
    @:luaDotMethod public function setPointSize(size: Float): Void;
    @:luaDotMethod public function getProjection(view: Int, ?matrix: LovrMat4): Rest<Any>;
    @:luaDotMethod public function setProjection(view: Int, ?matrix_or_left: EitherType<LovrMat4, Float>, ?right: Float, ?up: Float, ?down: Float): Void;
    @:luaDotMethod public function reset(): Void;
    @:luaDotMethod public function getShader(): LovrShader;
    @:luaDotMethod public function setShader(?shader: LovrShader): Void;
    @:luaDotMethod public function getStats(): LovrGraphicsStats;
    @:luaDotMethod public function getStencilTest(): LovrStrencilInfo;
    @:luaDotMethod public function getViewPose(index: Int, ?matrix: LovrMat4, ?invert: Bool): EitherType<LovrPose, LovrMat4>;
    @:luaDotMethod public function setViewPose(index: Int, ?matrix_or_x: EitherType<LovrMat4, Float>, ?inverted_or_y: EitherType<Bool, Float>, ?z: Float, ?angle: Float, ?ax: Float, ?ay: Float, ?az: Float): Void;
    @:luaDotMethod public function getWinding(): EitherType<String, LovrWinding>;
    @:luaDotMethod public function setWinding(winding: EitherType<String, LovrWinding>): Void;
    @:luaDotMethod public function isWireframe(): Bool;
    @:luaDotMethod public function setWireframe(wireframe: Bool): Void;
    @:luaDotMethod public function clear(args: Rest<Any>): Void;
    @:luaDotMethod public function createWindow(flags: LovrWindowFlags): Void;
    @:luaDotMethod public function getDimensions(): LovrDimensions;
    @:luaDotMethod public function getFeatures(): LovrGraphicsFeatures;
    @:luaDotMethod public function hasWindow(): Bool;
    @:luaDotMethod public function getHeight(): Int;
    @:luaDotMethod public function getLimits(): LovrGraphicsLimits;
    @:luaDotMethod public function getPixelDensity(): Float;
    @:luaDotMethod public function present(): Void;
    @:luaDotMethod public function tick(label: String): Void;
    @:luaDotMethod public function tock(label: String): Float;
    @:luaDotMethod public function getWidth(): Int;
}

@:multiReturn
extern class LovrHeadsetClipDistance {
    var near: Float;
    var far: Float;
}

@:enum abstract LovrHeadsetDriver(String) {
    var DESKTOP = "desktop";
    var OCULUS = "oculus";
    var OPENVR = "openvr";
    var OPENXR = "openxr";
    var VRAPI = "vrapi";
    var PICO = "pico";
    var WEBXR = "webxr";
}

@:enum abstract LovrCompareMode(String) {
    var EQUAL = "equal";
    var NOTEQUAL = "notequal";
    var LESS = "less";
    var LEQUAL = "lequal";
    var GEQUAL = "gequal";
    var GREATER = "greater";
}

@:enum abstract LovrFilterMode(String) {
    var NEAREST = "nearest";
    var BILINEAR = "bilinear";
    var TRILINEAR = "trilinear";
}

@:multiReturn
extern class LovrFilter {
    var mode: EitherType<String, LovrFilterMode>;
    var anisotropy: Float;
}

@:enum abstract LovrTextureFormat(String) {
    var RGB = "rgb";
    var RGBA = "rgba";
    var RGBA4 = "rgba4";
    var RGBA16F = "rgba16f";
    var RGBA32F = "rgba32f";
    var R16F = "r16f";
    var R32F = "r32f";
    var RG16F = "rg16f";
    var RG32F = "rg32f";
    var RGB5A1 = "rgb5a1";
    var RGB10A2 = "rgb10a2";
    var RG11B10F = "rg11b10f";
    var D16 = "d16";
    var D32F = "d32f";
    var D24S8 = "d24s8";
}

extern class LovrBlob {
    public function new();
    public function getName(): String;
    public function getPointer(): UserData;
    public function getSize(): Int;
    public function getString(): String;
}

extern class LovrImage {
    public function new();
    public function getBlob(): LovrBlob;
    public function getDimensions(): LovrDimensions;
    public function encode(): LovrBlob;
    public function getFormat(): LovrTextureFormat;
    public function getHeight(): Int;
    public function paste(source: LovrImage, ?x: Float = 0, ?y: Float = 0, ?fromX: Float = 0, ?fromY: Float = 0, ?width: Int, ?height: Int): Void;
    public function getPixel(x: Float, y: Float): LovrColor; 
    public function setPixel(x: Float, y: Float, r: Float, g: Float, b: Float, ?a: Float = 1): Void;
    public function getWidth(): Int;
}

@:multiReturn
extern class LovrColor {
    var r: Float;
    var g: Float;
    var b: Float;
    var a: Float;
}

@:enum abstract LovrTextureType(String) {
    var TYPE_2D = "2d";
    var TYPE_ARRAY = "array";
    var TYPE_CUBE = "cube";
    var TYPE_VOLUME = "volume";
}

@:enum abstract LovrWrapMode(String) {
    var CLAMP = "clamp";
    var REPEAT = "repeat";
    var MIRROREDREPEAT = "mirroredrepeat";
}

@:multiReturn
extern class LovrTextureWrap {
    var horizontal: LovrWrapMode;
    var vertical: LovrWrapMode;
}

extern class LovrTexture {
    public function new();
    public function getCompareMode(): EitherType<String, LovrCompareMode>;
    public function setCompareMode(mode: EitherType<String, LovrCompareMode>): Void;
    public function getDepth(): Float;
    public function getDimensions(?mipmaps: Float = 1): LovrDimensions;
    public function getFilter(): LovrFilter;
    public function setFilter(mode: EitherType<String, LovrFilterMode>, anisotropy: Float): Void;
    public function getFormat(): EitherType<String, LovrTextureFormat>;
    public function getHeight(mipmap: Int): Int;
    public function getMipmapCount(): Int;
    public function replacePixels(image: LovrImage, ?x: Float = 0, ?y: Float = 0, ?slice: Float = 1, ?mipmap: Float = 1): Void;
    public function getType(): EitherType<String, LovrTextureType>;
    public function getWidth(mipmap: Int): Int;
    public function getWrap(): LovrTextureWrap;
    public function setWrap(horizontal: LovrWrapMode, vertical: LovrWrapMode): Void;
}

@:enum abstract LovrHeadsetOrigin(String) {
    var HEAD = "head";
    var FLOOR = "floor";
}

@:multiReturn
extern class LovrHeadsetViewAngle {
    var left: Float;
    var right: Float;
    var top: Float;
    var bottom: Float;
}

@:multiReturn
extern class LovrHeadsetViewPose {
    var x: Float;
    var y: Float;
    var z: Float;
    var angle: Float;
    var ax: Float;
    var ay: Float;
    var az: Float;
}

@:enum abstract LovrDevice(String) {
    var HEAD = "head";
    var HAND_LEFT = "hand/left";
    var HAND_RIGHT = "hand/right";
    var LEFT = "left";
    var RIGHT = "right";
    var ELBOW_LEFT = "elbow/left";
    var ELBOW_RIGHT = "elbow/right";
    var SHOULDER_LEFT = "shoulder/left";
    var SHOULDER_RIGHT = "shoulder/right";
    var CHEST = "chest";
    var WAIST = "waist";
    var KNEE_LEFT = "knee/left";
    var KNEE_RIGHT = "knee/right";
    var FOOT_LEFT = "foot/left";
    var FOOT_RIGHT = "foot/right";
    var CAMERA = "camera";
    var KEYBOARD = "keyboard";
    var EYE_LEFT = "eye/left";
    var EYE_RIGHT = "eye/right";
    var BEACON1 = "beacon/1";
    var BEACON2 = "beacon/2";
    var BEACON3 = "beacon/3";
    var BEACON4 = "beacon/4";
}

@:enum abstract LovrMaterialColorType(String) {
    var DIFFUSE = "diffuse";
    var EMISSIVE = "emissive";
}

@:enum abstract LovrMaterialScalar(String) {
    var METALNESS = "metalness";
    var ROUGHNESS = "roughness";
}

@:multiReturn
extern class LovrHeadsetTransform {
    var ox: Float;
    var oy: Float;
    var sx: Float;
    var sy: Float;
    var angle: Float; 
}

extern class LovrMaterial {
    public function new();
    public function getColor(colorType: EitherType<String, LovrMaterialColorType>): LovrColor;
    public function setColor(colorType: EitherType<String, LovrMaterialColorType>, r: Float, g: Float, b: Float, ?a: Float = 1): Void;
    public function getScalar(scalarType: EitherType<String, LovrMaterialScalar>): Float;
    public function setScalar(scalarType: EitherType<String, LovrMaterialScalar>, x: Float): Void;
    public function getTransform(): LovrHeadsetTransform;
    public function setTransform(ox: Float, oy: Float, sx: Float, sy: Float, angle: Float): Void;
}

extern class LovrModel {
    public function new();
    public function getAABB(): LovrAABB;
    public function animate(name_or_index: EitherType<Int, String>, time: Float, ?alpha: Float = 1): Void;
    public function getAnimationCount(): Int;
    public function getAnimationDuration(): Void;
    public function getAnimationName(index: Int): String;
    public function draw(?x_or_transform: EitherType<LovrMat4, Float>, ?y_or_instances: Float, ?z: Float = 0, ?scale: Float = 1, ?angle: Float = 0, ?ax: Float = 0, ?ay: Float = 1, ?az: Float = 0, ?instances: Float = 1): Void;
    public function hasJoints(): Bool;
    public function getMaterial(name_or_index: EitherType<String, Int>): LovrMaterial;
}

@:enum abstract LovrDeviceAxis(String) {
    var TRIGGER = "trigger";
    var THUMBSTICK = "thumbstick";
    var TOUCHPAD = "touchpad";
    var GRIP = "grip";
}

@:enum abstract LovrButton(String) {
    var TRIGGER = "trigger";
    var THUMBSTICK = "thumbstick";
    var TOUCHPAD = "touchpad";
    var GRIP = "grip";
    var MENU = "menu";
    var A = "a";
    var B = "b";
    var X = "x";
    var Y = "y";
    var PROXIMITY = "proximity";
}

typedef LovrModelOptions = {
    var ?animated: Bool;
}

extern class LovrHeadsetModule {
    public function new();
    @:luaDotMethod public function getClipDistance(): LovrHeadsetClipDistance;
    @:luaDotMethod public function setClipDistance(near: Float, far: Float): Void;
    @:luaDotMethod public function getDisplayDimensions(): LovrDimensions;
    @:luaDotMethod public function getDisplayFrequency(): Float;
    @:luaDotMethod public function getDisplayHeight(): Float;
    @:luaDotMethod public function getDisplayMask(): Array<Array<Float>>;
    @:luaDotMethod public function getDisplayWidth(): Float;
    @:luaDotMethod public function getDriver(): EitherType<String, LovrHeadsetDriver>;
    @:luaDotMethod public function getMirrorTexture(): EitherType<String, LovrTexture>;
    @:luaDotMethod public function getName(): String;
    @:luaDotMethod public function getOriginType(): EitherType<String, LovrHeadsetOrigin>;
    @:luaDotMethod public function renderTo(callback: Function): Void;
    @:luaDotMethod public function getViewAngles(view: Float): LovrHeadsetViewAngle;
    @:luaDotMethod public function getViewCount(): Int;
    @:luaDotMethod public function getViewPose(view: Float): LovrHeadsetViewPose;
    @:luaDotMethod public function getAngularVelocity(device: EitherType<String, LovrDevice>): LovrPos;
    @:luaDotMethod public function animate(?device_or_model: EitherType<LovrModel, EitherType<String, LovrDevice>>, model: LovrModel): Void;
    //@:multiReturn @:luaDotMethod public function getAxis(device: EitherType<String, LovrDevice>, axis: EitherType<String, LovrDeviceAxis>): Rest<Float>;
    @:luaDotMethod public function getAxis(device: EitherType<String, LovrDevice>, axis: EitherType<String, LovrDeviceAxis>): Any;
    @:luaDotMethod public function isDown(device: EitherType<String, LovrDevice>, button: EitherType<String, LovrButton>): Bool;
    @:luaDotMethod public function getHands(): Array<LovrDevice>;
    @:luaDotMethod public function newModel(?device_or_options: EitherType<EitherType<String, LovrDevice>, LovrModelOptions>, ?options: LovrModelOptions): LovrModel;
    @:luaDotMethod public function getOrientation(?device: EitherType<String, LovrDevice> = LovrDevice.HEAD): LovrOrientation;
    @:luaDotMethod public function getPose(?device: EitherType<String, LovrDevice> = LovrDevice.HEAD): LovrPose;
    @:luaDotMethod public function getPosition(?device: EitherType<String, LovrDevice> = LovrDevice.HEAD): LovrPos;
    @:luaDotMethod public function isTouched(device: EitherType<String, LovrDevice>, button: EitherType<String, LovrButton>): Bool;
    @:luaDotMethod public function isTracked(?device: EitherType<String, LovrDevice>): Bool;
    @:luaDotMethod public function getVelocity(?device: EitherType<String, LovrDevice>): LovrVelocity;
    @:luaDotMethod public function vibrate(?device: EitherType<String, LovrDevice>, ?strength: Float = 1, ?duration: Float = 0.5, ?frequency: Float = 0): Bool;
    @:luaDotMethod public function wasPressed(device: EitherType<String, LovrDevice>, button: EitherType<String, LovrButton>): Bool;
    @:luaDotMethod public function wasReleased(device: EitherType<String, LovrDevice>, button: EitherType<String, LovrButton>): Bool;
    @:luaDotMethod public function getBoundsDepth(): Float;
    @:luaDotMethod public function getBoundsDimensions(): LovrDimensions;
    @:luaDotMethod public function getBoundsGeometry(?t: Array<Dynamic>): Array<Dynamic>;
    @:luaDotMethod public function getBoundsWidth(): Float;
}

@:multiReturn
extern class LovrRandomSeed {
    var low: Int;
    var high: Int;
}

extern class LovrRandomGenerator {
    public function new();
    public function random(?low_or_high: Float, ?high: Float): Float;
    public function randomNormal(?sigma: Float = 1, ?mu: Float = 0): Float;
    public function getState(): String;
    public function getSeed(): LovrRandomSeed;
    public function setSeed(): Void;
    public function setState(state: String): Void;
}

extern class LovrVec2 {
    public function new();
    public var x(default, null): Float;
    public var y(default, null): Float;
    public var z(default, null): Float;
    public var w(default, null): Float;
    public var r(default, null): Float;
    public var g(default, null): Float;
    public var b(default, null): Float;
    public var a(default, null): Float;
    public var s(default, null): Float;
    public var t(default, null): Float;
    public var p(default, null): Float;
    public var q(default, null): Float;

    public function set(args: Rest<Dynamic>): LovrVec2;
    public function add(v: EitherType<LovrVec2, Float>): LovrVec2;
    public function distance(u: LovrVec2): Float;
    public function div(v: EitherType<LovrVec2, Float>): LovrVec2;
    public function dot(v: LovrVec2): Float;
    public function length(): Float;
    public function lerp(u: LovrVec2, t: Float): LovrVec2;
    public function mul(v: EitherType<LovrVec2, Float>): LovrVec2;
    public function normalize(): LovrVec2;
    public function sub(v: EitherType<LovrVec2, Float>): LovrVec2;
    public function unpack(): LovrPos;
}

extern class LovrVec3 {
    public function new();
    public var x(default, null): Float;
    public var y(default, null): Float;
    public var z(default, null): Float;
    public var w(default, null): Float;
    public var r(default, null): Float;
    public var g(default, null): Float;
    public var b(default, null): Float;
    public var a(default, null): Float;
    public var s(default, null): Float;
    public var t(default, null): Float;
    public var p(default, null): Float;
    public var q(default, null): Float;

    public function set(args: Rest<Dynamic>): LovrVec3;
    public function add(v: EitherType<LovrVec3, Float>): LovrVec3;
    public function cross(u: LovrVec3): LovrVec3;
    public function distance(u: LovrVec3): Float;
    public function div(v: EitherType<LovrVec3, Float>): LovrVec3;
    public function dot(v: LovrVec3): Float;
    public function length(): Float;
    public function lerp(u: LovrVec3, t: Float): LovrVec3;
    public function mul(v: EitherType<LovrVec3, Float>): LovrVec3;
    public function normalize(): LovrVec3;
    public function sub(v: EitherType<LovrVec3, Float>): LovrVec3;
    public function unpack(): LovrPos;
}

extern class LovrVec4 {
    public function new();
    public var x(default, null): Float;
    public var y(default, null): Float;
    public var z(default, null): Float;
    public var w(default, null): Float;
    public var r(default, null): Float;
    public var g(default, null): Float;
    public var b(default, null): Float;
    public var a(default, null): Float;
    public var s(default, null): Float;
    public var t(default, null): Float;
    public var p(default, null): Float;
    public var q(default, null): Float;

    public function set(args: Rest<Dynamic>): LovrVec4;
    public function add(v: EitherType<LovrVec4, Float>): LovrVec4;
    public function distance(u: LovrVec4): Float;
    public function div(v: EitherType<LovrVec4, Float>): LovrVec4;
    public function dot(v: LovrVec4): Float;
    public function length(): Float;
    public function lerp(u: LovrVec4, t: Float): LovrVec4;
    public function mul(v: EitherType<LovrVec4, Float>): LovrVec4;
    public function normalize(): LovrVec4;
    public function sub(v: EitherType<LovrVec4, Float>): LovrVec4;
    public function unpack(): LovrPos;
}

@:multiReturn
extern class LovrQuatNums {
    var a: Float;
    var b: Float;
    var c: Float;
    var d: Float;
}

extern class LovrQuat {
    public function new();
    public function set(?angle_or_v: EitherType<EitherType<Float, LovrVec3>, LovrMat4>, ?ax_or_u: EitherType<LovrVec3, Float>, ?ay: Float = 0, ?az: Float = 0, ?raw: Bool = false): LovrQuat;
    public function conjugate(): LovrQuat;
    public function direction(): LovrVec3;
    public function length(): Int;
    public function mul(v: EitherType<LovrQuat, LovrVec3>): EitherType<LovrQuat, LovrVec3>;
    public function normalize(): LovrQuat;
    public function slerp(r: LovrQuat, t: Float): LovrQuat;
    public function unpack(?raw: Bool): LovrQuatNums;
}

@:multiReturn
extern class LovrMat4Nums {
    var m0: Float;
    var m1: Float;
    var m2: Float;
    var m3: Float;
    var m4: Float;
    var m5: Float;
    var m6: Float;
    var m7: Float;
    var m8: Float;
    var m9: Float;
    var m10: Float;
    var m11: Float;
    var m12: Float;
    var m13: Float;
    var m14: Float;
    var m15: Float;
}

extern class LovrMat4 {
    public function new();
    public function set(args: Rest<Dynamic>): LovrMat4;
    public function fov(left: Float, right: Float, up: Float, down: Float, near: Float, far: Float): LovrMat4;
    public function identity(): LovrMat4;
    public function invert(): LovrMat4;
    public function lookAt(from: LovrVec3, to: LovrVec3, ?up: LovrVec3): LovrMat4;
    public function mul(n: EitherType<LovrMat4, EitherType<LovrVec3, LovrVec4>>): EitherType<LovrMat4, EitherType<LovrVec3, LovrVec4>>;
    public function orthographic(left: Float, right: Float, up: Float, down: Float, near: Float, far: Float): LovrMat4;
    public function perspective(near: Float, far: Float, fov: Float, aspect: Float): LovrMat4;
    public function rotate(?quat_or_angle: EitherType<LovrQuat, Float>, ?ax: Float = 0, ?ay: Float = 0, ?az: Float = 0): LovrMat4;
    public function scale(?vec3_or_sx: EitherType<LovrVec3, Float>, ?sx_or_sy: Float = 0, ?sy_or_sz: Float = 0, ?sz: Float = 0): LovrMat4;
    public function target(from: LovrVec3, to: LovrVec3, ?up: LovrVec3): LovrMat4;
    public function translate(?v_or_x: EitherType<LovrVec3, Float>, ?y: Float, ?z: Float): LovrMat4;
    public function transpose(): LovrMat4;
    public function unpack(raw: Bool): LovrMat4Nums;
}

@:multiReturn
extern class LinearNums {
    var lr: Float;
    var lg: Float;
    var lb: Float;
}

@:multiReturn
extern class GammaNums {
    var gr: Float;
    var gg: Float;
    var gb: Float;
}

extern class LovrCurve {
    public function new();
    public function slice(t1: Float, t2: Float): LovrCurve;
    public function addPoint(x: Float, y: Float, z: Float, ?index: Int): Void;
    public function getPoint(index: Int): LovrPos;
    public function setPoint(index: Int, x: Float, y: Float, z: Float): Void;
    public function getPointCount(): Int;
    public function removePoint(index: Int): Void;
    public function render(?n: Int = 32, ?t1: Int = 1, ?t2: Int = 0): Array<Float>;
    public function getTangent(t: Float): LovrPos;
}

extern class LovrMathModule {
    public function new();
    @:luaDotMethod public function newRandomGenerator(?low_or_seed: EitherType<Float, Int>, ?high: Float): LovrRandomGenerator;
    @:luaDotMethod public function noise(x: Float, ?y: Float, ?z: Float, ?w: Float): Float;
    @:luaDotMethod public function random(?x_or_high_or_low: Float, ?high: Float): Float;
    @:luaDotMethod public function randomNormal(?sigma: Float = 1, ?mu: Float = 0): Float;
    @:luaDotMethod public function getRandomSeed(): Int;
    @:luaDotMethod public function setRandomSeed(seed: Int): Void;
    @:luaDotMethod public function drain(): Void;
    @:luaDotMethod public function mat4(): LovrMat4;
    @:luaDotMethod public function newMat4(): LovrMat4;
    @:luaDotMethod public function newQuat(): LovrQuat;
    @:luaDotMethod public function newVec2(): LovrVec2;
    @:luaDotMethod public function newVec3(): LovrVec3;
    @:luaDotMethod public function newVec4(): LovrVec4;
    @:luaDotMethod public function quat(): LovrQuat;
    @:luaDotMethod public function vec2(): LovrVec2;
    @:luaDotMethod public function vec3(): LovrVec3;
    @:luaDotMethod public function vec4(): LovrVec4;
    @:luaDotMethod public function gammaToLinear(gr: Float, gg: Float, gb: Float): LinearNums;
    @:luaDotMethod public function linearToGamma(lr: Float, lg: Float, lb: Float): GammaNums;
    @:luaDotMethod public function newCurve(?x_or_p: EitherType<Float, Array<Float>>, ?y: Float, ?z: Float, args: Rest<Float>): LovrCurve;
}

@:enum abstract LovrPermissions(String) {
    var AUDIOCAPTURE = "audiocapture";
}

@:enum abstract LovrShapeType(String) {
    var BOX         = "box";
    var CAPSULE     = "capsule";
    var CYLINDER    = "cylinder";
    var SPHERE      = "sphere";
}

@:multiReturn
extern class LovrPos {
    var x: Float;
    var y: Float;
    var z: Float;
}

@:multiReturn
extern class LovrOrientation {
    var angle: Float;
    var ax: Float;
    var ay: Float;
    var az: Float;
}

@:multiReturn
extern class LovrMass {
    var cx: Float;
    var cy: Float;
    var cz: Float;
    var mass: Float;
    var inertia: Array<Float>;
}

extern class LovrShape {
    public function new();
    public function getAABB(): LovrAABB;
    public function getCollider(): LovrCollider;
    public function destroy(): Void;
    public function isEnabled(): Bool;
    public function setEnabled(enabled: Bool): Void;
    public function getMass(density: Float): LovrMass;
    public function getOrientation(): LovrOrientation;
    public function setOrientation(angle: Float, ax: Float, ay: Float, az: Float): Void;
    public function getPosition(): LovrPos;
    public function setPosition(x: Float, y: Float, z: Float): Void;
    public function isSensor(): Bool;
    public function setSensor(sensor: Bool): Void;
    public function getType(): EitherType<String, LovrShapeType>;
    public function getUserData(): UserData;
    public function setUserData(data: UserData): Void;
}

@:multiReturn
extern class LovrVelocity {
    var vx: Float;
    var vy: Float;
    var vz: Float;
}

@:multiReturn
extern class LovrDamping {
    var damping: Float;
    var threshold: Float;
}

@:multiReturn
extern class LovrAABB {
    var minx: Float;
    var maxx: Float;
    var miny: Float;
    var maxy: Float;
    var minz: Float;
    var maxz: Float;
}

@:enum abstract LovrJoingType(String) {
    var BALL        = "ball";
    var DISTANCE    = "distance";
    var HINGE       = "hinge";
    var SLIDER      = "slider";
}

@:multiReturn
extern class LovrJointColliders {
    var colliderA: LovrCollider;
    var colliderB: LovrCollider;
}

extern class LovrJoint {
    public function new();
    public function getColliders(): LovrJointColliders;
    public function destroy(): Void;
    public function isEnabled(): Bool;
    public function setEnabled(enabled: Bool): Void;
    public function getType(): EitherType<String, LovrJoingType>;
    public function getUserData(): UserData;
    public function setUserData(data: UserData): Void;
}

@:multiReturn
extern class LovrPose {
    var x: Float;
    var y: Float;
    var z: Float;
    var angle: Float;
    var ax: Float;
    var ay: Float;
    var az: Float;
}

extern class LovrCollider {
    public function new();
    public function getAABB(): LovrAABB;
    public function addShape(shape: LovrShape): Void;
    public function getAngularDamping(): LovrDamping;
    public function setAngularDamping(damping: Float, ?threshold: Float = 0): Void;
    public function getAngularVelocity(): LovrVelocity;
    public function setAngularVelocity(vx: Float, vy: Float, vz: Float): Void;
    public function applyForce(x: Float, y: Float, z: Float, ?vx: Float, ?vy: Float, ?vz: Float): Void;
    public function applyTorque(x: Float, y: Float, z: Float): Void;
    public function isAwake(): Bool;
    public function setAwake(awake: Bool): Void;
    public function destroy(): Void;
    public function getFriction(): Float;
    public function setFriction(friction: Float): Void;
    public function isGravityIgnored(): Bool;
    public function setGravityIgnored(ignored: Bool): Void;
    public function getJoints(): Array<LovrJoint>;
    public function isKinematic(): Bool;
    public function setKinematic(kinematic: Bool): Void;
    public function getLinearDamping(): LovrDamping;
    public function setLinearDamping(damping: Float, ?threshold: Float = 0): Void;
    public function getLinearVelocity(): LovrVelocity;
    public function setLinearVelocity(vx: Float, vy: Float, vz: Float): Void;
    public function getLinearVelocityFromLocalPoint(x: Float, y: Float, z: Float): LovrVelocity;
    public function getLinearVelocityFromWorldPoint(x: Float, y: Float, z: Float): LovrVelocity;
    public function getLocalCenter(): LovrPos;
    public function getLocalPoint(wx: Float, wy: Float, wz: Float): LovrPos;
    public function getLocalVector(wx: Float, wy: Float, wz: Float): LovrPos;
    public function getMass(): Float;
    public function setMass(mass: Float): Void;
    public function getMassData(): LovrMass;
    public function setMassData(cx: Float, cy: Float, cz: Float, mass: Float, inertia: Array<Float>): Void;
    public function getOrientation(): LovrOrientation;
    public function setOrientation(angle: Float, ax: Float, ay: Float, az: Float): Void;
    public function getPose(): LovrPose;
    public function setPose(x: Float, y: Float, z: Float, angle: Float, ax: Float, ay: Float, az: Float): Void;
    public function removeShape(shape: LovrShape): Void;
    public function getRestitution(): Float;
    public function setRestitution(restitution: Float): Void;
    public function getShapes(): Array<LovrShape>;
    public function isSleepingAllowed(): Bool;
    public function setSleepingAllowed(allowed: Bool): Void;
    public function getTag(): String;
    public function setTag(tag: String): Void;
    public function getUserData(): UserData;
    public function setUserData(data: UserData): Void;
    public function getWorld(): LovrWorld;
    public function getWorldPoint(wx: Float, wy: Float, wz: Float): LovrPos;
    public function getWorldVector(wx: Float, wy: Float, wz: Float): LovrPos;
}

@:multiReturn
extern class LovrDimensions {
    var width: Float;
    var height: Float;
    var depth: Float;
}

extern class LovrBoxCollider extends LovrCollider {
    public function new();
    public function getDimensions(): LovrDimensions;
    public function setDimensions(width: Float, height: Float, depth: Float): Void;
}

extern class LovrCapsuleCollider extends LovrCollider {
    public function new();
    public function getLength(): Float;
    public function setLength(length: Float): Void;
    public function getRadius(): Float;
    public function setRadius(radius: Float): Void;
}

extern class LovrCylinderCollider extends LovrCollider {
    public function new();
    public function getLength(): Float;
    public function setLength(length: Float): Void;
    public function getRadius(): Float;
    public function setRadius(radius: Float): Void;
}

extern class LovrMeshCollider extends LovrCollider {
    public function new();
}

extern class LovrSphereCollider extends LovrCollider {
    public function new();
    public function getDimensions(): Float;
    public function setDimensions(radius: Float): Void;
}

@:multiReturn
extern class LovrShapeCollision {
    var shapeA: LovrShape;
    var shapeB: LovrShape;
}

extern class LovrWorld {
    public function new();
    public function destroy(): Void;    
    public function raycast(x1: Float, y1: Float, z1: Float, x2: Float, y2: Float, z2: Float, callback: Dynamic->Float->Float->Float->Float->Float->Float): Void;
    public function update(dt: Float, ?resolver: LovrWorld->Void): Void;
    public function getColliders(): Array<LovrCollider>;
    public function newBoxCollider(?x: Float = 0, ?y: Float = 0, ?z: Float = 0, ?width: Float = 1, ?height: Float = 1, ?depth: Float = 1): LovrBoxCollider;
    public function newCapsuleCollider(?x: Float = 0, ?y: Float = 0, ?z: Float = 0, ?radius: Float = 1, ?length: Float=  1): LovrCapsuleCollider;
    public function newCollider(?x: Float = 0, ?y: Float = 0, ?z: Float = 0): LovrCollider;
    public function newCylinderCollider(?x: Float = 0, ?y: Float = 0, ?z: Float = 0, ?radius: Float = 1, ?length: Float=  1): LovrCylinderCollider;
    public function newMeshCollider(vertices: Array<Array<Float>>, indices: Array<Int>): LovrMeshCollider;
    public function newSphereCollider(?x: Float = 0, ?y: Float = 0, ?z: Float = 0, ?radius: Float = 1): LovrSphereCollider;
    public function getAngularDamping(): LovrDamping;
    public function setAngularDamping(damping: Float, ?threshold: Float = 0): Void;
    public function getGravity(): LovrPos;
    public function setGravity(gx: Float, gy: Float, gz: Float): Void;
    public function getLinearDamping(): LovrDamping;
    public function setLinearDamping(damping: Float, ?threshold: Float = 0): Void;
    public function getResponseTime(): Float;
    public function setResponseTime(responseTime: Float): Void;
    public function isSleepingAllowed(): Bool;
    public function setSleepingAllowed(allowed: Bool): Void;
    public function getTightness(): Float;
    public function setTightness(tightness: Float): Void;
    public function collide(shapeA: LovrShape, shapeB: LovrShape, friction: Float, restitution: Float): Bool;
    public function isCollisionEnabledBetween(tag1: String, tag2: String): Bool;
    public function computeOverlaps(): Void;
    public function disableCollisionBetween(tag1: String, tag2: String): Void;
    public function enableCollisionBetween(tag1: String, tag2: String): Void;
    public function overlaps(): Array<LovrShapeCollision>;
}

extern class LovrBoxShape extends LovrShape {
    public function new();
    public function getDimensions(): LovrDimensions;
    public function setDimensions(width: Float, height: Float, depth: Float): Void;
}

extern class LovrCapsuleShape extends LovrShape {
    public function new();
    public function getLength(): Float;
    public function setLength(length: Float): Void;
    public function getRadius(): Float;
    public function setRadius(radius: Float): Void;
}

extern class LovrCylinderShape extends LovrShape {
    public function new();
    public function getLength(): Float;
    public function setLength(length: Float): Void;
    public function getRadius(): Float;
    public function setRadius(radius: Float): Void;
}

extern class LovrSphereShape extends LovrShape {
    public function new();
    public function getDimensions(): Float;
    public function setDimensions(radius: Float): Void;
}

@:multiReturn
extern class LovrJointAnchors {
    var x1: Float;
    var y1: Float;
    var z1: Float;
    var x2: Float;
    var y2: Float;
    var z2: Float;
}

extern class LovrBallJoint extends LovrJoint {
    public function new();
    public function setAnchor(x: Float, y: Float, z: Float): Void;
    public function getAnchors(): LovrJointAnchors;
    public function getResponseTime(): Float;
    public function setResponseTime(responseTime: Float): Void;
    public function getTightness(): Float;
    public function setTightness(tightness: Float): Void;
}

extern class LovrDistanceJoint extends LovrJoint {
    public function new();
    public function getAnchors(): LovrJointAnchors;
    public function setAnchors(x1: Float, y1: Float, z1: Float, x2: Float, y2: Float, z2: Float): Void;
    public function getDistance(): Float;
    public function setDistance(distance: Float): Void;
    public function getResponseTime(): Float;    
    public function setResponseTime(responseTime: Float): Void;
    public function getTightness(): Float;
    public function setTightness(tightness: Float): Void;
}

@:multiReturn
extern class LovrJointLimits {
    var lower: Float;
    var upper: Float;
}

extern class LovrHingeJoint extends LovrJoint {
    public function new();
    public function setAnchor(x: Float, y: Float, z: Float): Void;
    public function getAnchors(): LovrJointAnchors;
    public function getAngle(): Float;
    public function getAxis(): LovrPos;
    public function setAxis(x: Float, y: Float, z: Float): Void;
    public function getLimits(): LovrJointLimits;
    public function setLimits(lower: Float, upper: Float): Void;
    public function getLowerLimit(): Float;
    public function setLowerLimit(limit: Float): Void;
    public function getUpprtLimit(): Float;
    public function setUpperLimit(limit: Float): Void;
}

extern class LovrSliderJoint extends LovrJoint {
    public function new();
    public function setAnchor(x: Float, y: Float, z: Float): Void;
    public function getAnchors(): LovrJointAnchors;
    public function getLimits(): LovrJointLimits;
    public function setLimits(lower: Float, upper: Float): Void;
    public function getLowerLimit(): Float;
    public function setLowerLimit(limit: Float): Void;
    public function getUpprtLimit(): Float;
    public function setUpperLimit(limit: Float): Void;
}

extern class LovrPhysicsModule {
    public function new();
    @:luaDotMethod public function newWorld(?xg: Float = 0, ?yg: Float = -9.81, ?zg: Float = 0, ?allowSleep: Bool = true, ?tags: Array<String>): LovrWorld;
    @:luaDotMethod public function newBoxShape(?width: Float = 1, ?height: Float = 1, ?depth: Float = 1): LovrBoxShape;
    @:luaDotMethod public function newCapsuleShape(?radius: Float = 1, ?length: Float = 1): LovrCapsuleShape;
    @:luaDotMethod public function newCylinderShape(?radius: Float = 1, ?length: Float = 1): LovrCylinderShape;
    @:luaDotMethod public function newSphereShape(?radius: Float = 1): LovrSphereShape;
    @:luaDotMethod public function newBallJoint(colliderA: LovrCollider, colliderB: LovrCollider, x: Float, y: Float, z: Float): LovrBallJoint;
    @:luaDotMethod public function newDistanceJoint(colliderA: LovrCollider, colliderB: LovrCollider, x1: Float, y1: Float, z1: Float, x2: Float, y2: Float, z2: Float): LovrDistanceJoint;
    @:luaDotMethod public function newHingeJoint(colliderA: LovrCollider, colliderB: LovrCollider, x: Float, y: Float, z: Float, ax: Float, ay: Float, az: Float): LovrHingeJoint;
    @:luaDotMethod public function newSliderJoint(colliderA: LovrCollider, colliderB: LovrCollider, ax: Float, ay: Float, az: Float): LovrSliderJoint;
}

extern class LovrSystemModule {
    public function new();
    @:luaDotMethod public function getCoreCount(): Int;
    @:luaDotMethod public function getOS(): String;
    @:luaDotMethod public function requestPermission(perimission: EitherType<String, LovrPermissions>): Void;
}

@:multiReturn
extern class ChannelPeekData {
    var message: Dynamic;
    var present: Bool;
}

@:multiReturn
extern class ChannelPushData {
    var id: EitherType<Int, Bool>;
    var read: Bool;
}

extern class LovrChannel {
    public function new();
    public function clear(): Void;
    public function hasRead(id: Int): Bool;
    public function peek(id: Int): ChannelPeekData;
    public function pop(wait: EitherType<Float, Bool>): Dynamic;
    public function push(message: Dynamic, wait: EitherType<Float, Bool>): ChannelPushData;
}

extern class LovrThread {
    public function new();
    public function getError(): String;
    public function isRunning(): Bool;
    public function start(args: Rest<Dynamic>): Void;
    public function wait(): Void;
}

extern class LovrThreadModule {
    public function new();
    @:luaDotMethod public function getChannel(name: String): LovrChannel;
    @:luaDotMethod public function newThread(code: String): LovrThread;
}

extern class LovrTimerModule {
    public function new();
    @:luaDotMethod public function getAverageDelta(): Float;
    @:luaDotMethod public function getDelta(): Float;
    @:luaDotMethod public function getFPS(): Float;
    @:luaDotMethod public function getTime(): Float;
    @:luaDotMethod public function sleep(duration: Float): Void;
    @:luaDotMethod public function step(): Float;
}

@:native("lovr")
extern class Lovr {
    public static var conf: Config->Void;
    public static var draw: Void->Void;
    public static var errhand: String->String->haxe.Constraints.Function;
    public static var focus: Bool->Void;
    public static var keypressed: String->Int->Bool->Void;
    public static var keyreleased: String->Int->Void;
    public static var load: Array<Dynamic>->Void;
    public static var log: String->String->String->Void;
    public static var mirror: Void->Void;
    public static var permission: String->Bool->Void;
    public static var quit: Void->Bool;
    public static var resize: Int->Int->Void;
    public static var restart: Void->Dynamic;
    public static var run: Void->haxe.Constraints.Function;
    public static var textinput: String->Int->Void;
    public static var threaderror: LovrThread->String->Void;
    public static var update: Float->Void;

    //public static var handlers: Array<Dynamic>;
    public static var handlers: Dynamic;
    public static function getVersion(): LovrVersion;
    public static function getOS(): String;
    
    public static var audio: LovrAudioModule;
    public static var data: LovrDataModule;
    public static var event: LovrEventModule;
    public static var filesystem: LovrFilesystemModule;
    public static var graphics: LovrGraphicsModule;
    public static var physics: LovrPhysicsModule;
    public static var math: LovrMathModule;
    public static var headset: LovrHeadsetModule;
    public static var thread: LovrThreadModule;
    public static var system: LovrSystemModule;
    public static var timer: LovrTimerModule;
}
