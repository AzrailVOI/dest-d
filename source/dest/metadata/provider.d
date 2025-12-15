module dest.metadata.provider;

import dest.metadata.structures;

/// Извлекает метаданные провайдера
ProviderMetadata extractProviderMetadata(T)()
{
    ProviderMetadata meta;
    meta.className = T.stringof;
    meta.scope_ = "singleton"; // По умолчанию singleton
    
    return meta;
}


