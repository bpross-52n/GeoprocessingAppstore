/*
 * See the NOTICE file distributed with
 * this work for additional information regarding copyright ownership.
 * Esri Inc. licenses this file to You under the Apache License, Version 2.0
 * (the "License"); you may not use this file except in compliance with
 * the License.  You may obtain a copy of the License at
 * 
 *     http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package com.esri.gpt.catalog.lucene;

import java.util.ArrayList;
import org.apache.lucene.document.Document;

/**
 * Array of Lucene index observers
 */
public class LuceneIndexObserverArray extends ArrayList<LuceneIndexObserver>{
  /**
   * Called BEFORE index document is being updated.
   * @param document Lucene document
   * @param uuid document UUID
   * @throws Exception if processing notification fails
   */
  public void onDocumentUpdate(Document document, String uuid) throws Exception {
    for (LuceneIndexObserver o:this) {
      o.onDocumentUpdate(document, uuid);
    }
  }
  /**
   * Called AFTER index document has been updated.
   * @param document Lucene document
   * @param uuid document UUID
   * @throws Exception if processing notification fails
   */
  public void onDocumentUpdated(Document document, String uuid) throws Exception {
    for (LuceneIndexObserver o:this) {
      o.onDocumentUpdated(document, uuid);
    }
  }
  /**
   * Called BEFORE index document is being deleted.
   * @param uuids UUIDs of documents to delete
   * @throws Exception if processing notification fails
   */
  public void onDocumentDelete(String [] uuids) throws Exception {
    for (LuceneIndexObserver o:this) {
      o.onDocumentDelete(uuids);
    }
  }
  /**
   * Called AFTER index document has been deleted.
   * @param uuids UUIDs of documents to delete
   * @throws Exception if processing notification fails
   */
  public void onDocumentDeleted(String [] uuids) throws Exception {
    for (LuceneIndexObserver o:this) {
      o.onDocumentDeleted(uuids);
    }
  }
}
