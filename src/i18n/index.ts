import idStrings from './id.json';
import enStrings from './en.json';

export type Lang = 'id' | 'en';
export const defaultLang: Lang = 'id';
export const languages = { id: 'Bahasa Indonesia', en: 'English' };

const translations = { id: idStrings, en: enStrings };

export function t(lang: Lang, key: string): string {
  const keys = key.split('.');
  let result: any = translations[lang];
  for (const k of keys) {
    result = result?.[k];
  }
  return result || key;
}

export function getLangFromCookie(cookieHeader: string | null | undefined): Lang {
  if (!cookieHeader) return defaultLang;
  const match = cookieHeader.match(/(?:^|;\s*)lang=(id|en)/);
  return (match?.[1] as Lang) || defaultLang;
}
